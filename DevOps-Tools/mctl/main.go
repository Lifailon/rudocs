package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"os/exec"
	"strings"
	"sync"
)

var colors = []string{
	"\033[32m",
	"\033[34m",
	"\033[35m",
	"\033[36m",
	"\033[33m",
	"\033[31m",
	"\033[37m",
}

const colorReset = "\033[0m"

// Функция для выполнения команды kubectl и вывода ее потоков вывода
func kubectl(args []string, ctxPrefix string) {
	cmd := exec.Command("kubectl", args...)
	stdout, _ := cmd.StdoutPipe()
	stderr, _ := cmd.StderrPipe()
	err := cmd.Start()
	if err != nil {
		return
	}
	// Параллельно и асинхронно читаем stdout и stderr, чтобы они не блокировали друг друга
	go streamOutput(stdout, os.Stdout, ctxPrefix)
	go streamOutput(stderr, os.Stderr, ctxPrefix)
	// Ожидаем завершения работы вызванного процесса kubectl
	cmd.Wait()
}

// Функция для построчного чтения потока данных (stdout или stderr)
func streamOutput(rc io.ReadCloser, stream *os.File, ctxPrefix string) {
	scanner := bufio.NewScanner(rc)
	for scanner.Scan() {
		fmt.Fprintf(stream, "%s%s\n", ctxPrefix, scanner.Text())
	}
	if err := scanner.Err(); err != nil {
		fmt.Fprintf(os.Stderr, "%s%s\n", ctxPrefix, fmt.Sprintf("Stream read error: %v", err))
	}
}

// Функция для проверки были ли передан флаг namespace
func isNamespaceFlag(args []string) bool {
	for _, arg := range args {
		if arg == "-n" || strings.HasPrefix(arg, "--namespace") || arg == "-A" || arg == "--all-namespaces" {
			return true
		}
	}
	return false
}

// Новая функция для обработки логов со всех подов во всех неймспейсах без флага namespace
func logReader(context, ctxPrefix string, args []string) {
	var labelSelector string
	var cleanLogArgs []string

	// Парсим флаги командной строки, чтобы отделить селекторы (labels) от других флагов
	for j := 1; j < len(args); j++ {
		arg := args[j]
		if arg == "-l" || arg == "--selector" {
			if j+1 < len(args) {
				labelSelector = args[j+1]
				j++
			}
		} else if strings.HasPrefix(arg, "-l=") {
			labelSelector = strings.TrimPrefix(arg, "-l=")
		} else if strings.HasPrefix(arg, "--selector=") {
			labelSelector = strings.TrimPrefix(arg, "--selector=")
		} else if arg != "-A" && arg != "--all-namespaces" {
			cleanLogArgs = append(cleanLogArgs, arg)
		}
	}

	// Получаем список подов во всех неймспейсах (-A) текущего контекста
	// Используем jsonpath, чтобы получить вывод в удобном формате: "имя_namespace имя_пода"
	// podArgs := []string{
	// 	"--context", context, "get", "pods", "-A",
	// 	"-o", "jsonpath={range .items[*]}{.metadata.namespace}{\" \"}{.metadata.name}{\"\\n\"}{end}",
	// }
	podArgs := []string{
		"--context", context, "get", "pods", "-A",
		"-o", "custom-columns=NS:.metadata.namespace,NAME:.metadata.name",
		"--no-headers",
	}

	// Добавляем фильтр по селектору, если он был передан
	if labelSelector != "" {
		podArgs = append(podArgs, "-l", labelSelector)
	}

	// Выполняем команду
	podsOut, _ := exec.Command("kubectl", podArgs...).Output()
	lines := strings.Split(strings.TrimSpace(string(podsOut)), "\n")

	// Группа ожидания чтения логов со всех найденных подов в текущем контексте
	var logsWg sync.WaitGroup
	for _, line := range lines {
		parts := strings.Fields(line)
		if len(parts) < 2 {
			continue
		}
		ns, podName := parts[0], parts[1]

		logsWg.Add(1)

		// Запускаем параллельное чтение логов для каждого найденного пода
		go func(nSpace, pName string) {
			defer logsWg.Done()
			// Формируем точечную команду чтения логов: kubectl --context <contextName> logs -n <namespace> <podName> <flags>
			cmdArgs := append([]string{"--context", context, "logs", "-n", nSpace, pName}, cleanLogArgs...)
			kubectl(cmdArgs, ctxPrefix)
		}(ns, podName)
	}

	// Ждем, пока завершится чтение логов всех подов в рамках этого контекста
	logsWg.Wait()
}

func main() {
	// Получаем аргументы командной строки, исключая имя бинарника
	args := os.Args[1:]
	if len(args) == 0 {
		os.Exit(1)
	}

	// Получаем список всех существующих контекстов из конфигурации
	output, err := exec.Command("kubectl", "config", "get-contexts", "-o", "name").Output()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error get contexts: %v\n", err)
		os.Exit(1)
	}

	// Парсим вывод и получаем массив имен контекстов
	contexts := strings.Fields(string(output))

	// Пересобираем массив, исключая пустые названия контекстов и вычисляем длину самого длинного имени контекста
	var contextArr []string
	maxLen := 0
	for _, ctx := range contexts {
		if ctx != "" {
			contextArr = append(contextArr, ctx)
			if len(ctx) > maxLen {
				maxLen = len(ctx)
			}
		}
	}

	var wg sync.WaitGroup

	// Проходимся по каждому контексту
	for i, ctx := range contextArr {
		wg.Add(1)

		// Выбираем доступный цвет для текущего контекста
		color := colors[i%len(colors)]

		// Запускаем отдельную горутину для работы с текущим контекстом
		go func(context, ctxColor string) {
			defer wg.Done()
			// Формируем префикс вывода с учетом максимальной длины имени контекста
			ctxPrefix := fmt.Sprintf("%s%-*s%s │ ", ctxColor, maxLen, context, colorReset)
			if args[0] == "logs" && !isNamespaceFlag(args) {
				logReader(context, ctxPrefix, args)
			} else {
				cmdArgs := append([]string{"--context", context}, args...)
				kubectl(cmdArgs, ctxPrefix)
			}
		}(ctx, color)
	}

	wg.Wait()
}
