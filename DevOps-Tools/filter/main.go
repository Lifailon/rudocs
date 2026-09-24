package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strings"
)

const (
	colorYellow = "\x1b[33m"
	colorReset  = "\x1b[0m"
)

func regexFilter(stdin *bufio.Scanner, pattern string, ignoreCase, noColor bool) {
	params := ""
	if ignoreCase {
		params = "(?i)"
	}

	re, err := regexp.Compile(params + pattern)
	if err != nil {
		fmt.Fprintln(os.Stderr, "Regex pattern error:", err)
		os.Exit(1)
		return
	}

	for stdin.Scan() {
		line := stdin.Text()
		if re.MatchString(line) {
			if noColor {
				fmt.Println(line)
				continue
			}
			fmt.Println(re.ReplaceAllStringFunc(line, func(m string) string {
				return colorYellow + m + colorReset
			}))
		}
	}
}

func containsFilter(stdin *bufio.Scanner, pattern string, ignoreCase, noColor bool) {
	// Разбиваем аргумент на отдельные слова для поиска
	filterWords := strings.Fields(pattern)
	if len(filterWords) == 0 {
		return
	}

	// Проходимся по каждой строке
	for stdin.Scan() {
		line := stdin.Text()
		matchAll := true

		// Проверяем, что все слова присутствуют в строке
		for _, word := range filterWords {
			if ignoreCase {
				// Приводим всю строку и искомое слово к нижнему регистру
				lineLower := strings.ToLower(line)
				wordLower := strings.ToLower(word)
				if !strings.Contains(lineLower, wordLower) {
					matchAll = false
					break
				}
			} else {
				if !strings.Contains(line, word) {
					matchAll = false
					break
				}
			}
		}

		if matchAll {
			if noColor {
				fmt.Println(line)
				continue
			}
			for _, word := range filterWords {
				if ignoreCase {
					lineLower := strings.ToLower(line)
					wordLower := strings.ToLower(word)
					// Ищем положение, где находится искомое слово в строке без учета регистра
					index := strings.Index(lineLower, wordLower)
					if index != -1 {
						// Извлекаем оригинальное слово с учетом регистра
						originalWord := line[index : index+len(word)]
						// Добавляем покраску
						wordColor := colorYellow + originalWord + colorReset
						// Заменяем слово с покраской в исходной строке
						line = strings.ReplaceAll(line, originalWord, wordColor)
					}
				} else {
					wordColor := colorYellow + word + colorReset
					line = strings.ReplaceAll(line, word, wordColor)
				}
			}
			fmt.Println(line)
		}
	}
}

func main() {
	if len(os.Args) < 2 {
		return
	}

	var pattern string
	var regexMode bool
	ignoreCase := true
	var noColor bool

	// Определяем аргументы командной строки
	for i := 1; i < len(os.Args); i++ {
		arg := os.Args[i]
		if strings.HasPrefix(arg, "--") {
			switch arg {
			case "--regex":
				regexMode = true
			case "--ignore-case":
				ignoreCase = false
			case "--no-color":
				noColor = true
			}
			continue
		}
		if strings.HasPrefix(arg, "-") && len(arg) > 1 {
			for _, char := range arg[1:] {
				switch char {
				case 'r':
					regexMode = true
				case 'i':
					ignoreCase = false
				case 'n':
					noColor = true
				}
			}
			continue
		}
		pattern = arg
	}

	// Помещаем stdin в сканнер
	scanner := bufio.NewScanner(os.Stdin)

	if regexMode && pattern != "" {
		regexFilter(scanner, pattern, ignoreCase, noColor)
	} else if pattern != "" {
		containsFilter(scanner, pattern, ignoreCase, noColor)
	}

	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "Read input error:", err)
		os.Exit(1)
	}
}
