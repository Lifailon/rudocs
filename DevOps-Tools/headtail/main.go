package main

import (
	"bytes"
	"flag"
	"fmt"
	"io"
	"os"
	"time"
)

func main() {
	// Определяем флаги командной строки
	filePath := flag.String("p", "/var/log/syslog", "File path")
	lines := flag.Int("l", 10, "Number of last lines to output")
	follow := flag.Bool("f", false, "Follow file changes in real time")
	head := flag.Bool("h", false, "Head mode (output lines from the beginning of the file)")
	flag.Parse()

	// Открываем файл
	file, err := os.Open(*filePath)
	if err != nil {
		fmt.Printf("Error opening file: %v\n", err)
		return
	}
	defer file.Close()

	// Если выбран head-режим, выводим строки с начала файла
	if *head {
		// Читаем файл с начала по 1КБ
		bufferSize := int64(1024)
		var block []byte
		var linesCount int

		for linesCount < *lines {
			block = make([]byte, bufferSize)
			n, _ := file.Read(block)
			if n == 0 {
				break
			}

			// Ищем новые строки с начала блока к концу
			end := -1
			for i := 0; i < n; i++ {
				if block[i] == '\n' {
					linesCount++
					// Если количество текущих строк равно указанным, выводим до конца последней
					if linesCount == *lines {
						end = i
						break
					}
				}
			}

			// Выводим строки до конца последней найденной
			if end >= 0 {
				fmt.Print(string(block[:end+1]))
				break
			}
			fmt.Print(string(block[:n]))
		}
	} else {
		// Получаем размер файла из статистики
		stat, _ := file.Stat()
		size := stat.Size()

		// Читаем файла с конца по 1КБ
		bufferSize := int64(1024)

		var blocks [][]byte
		var linesCount int

		for linesCount <= *lines && size > 0 {
			// Уменьшаем размер файла, если оставшийся размер файла меньше 1КБ
			if size < bufferSize {
				bufferSize = size
			}
			size -= bufferSize

			// Читаем блок данных
			block := make([]byte, bufferSize)
			file.Seek(size, io.SeekStart)
			file.Read(block)

			// Ищем новые строки с конца блока к началу
			for i := len(block) - 1; i >= 0; i-- {
				if block[i] == '\n' {
					linesCount++
					// Если количество текущих строк больше указанных, завершаем цикл
					if linesCount > *lines {
						block = block[i+1:]
						break
					}
				}
			}

			// Добавляем ссылку на кусок в конец списка
			blocks = append(blocks, block)
		}

		// Разворачиваем слайс блоков в обратном порядке
		for i, j := 0, len(blocks)-1; i < j; i, j = i+1, j-1 {
			blocks[i], blocks[j] = blocks[j], blocks[i]
		}

		// Склеиваем все blocks в один итоговый слайс байт
		result := bytes.Join(blocks, nil)
		fmt.Print(string(result))
	}

	if *follow && !*head {
		// Перемещаем курсор на самый конец файла, т.к. предыдущие строки уже выведены
		currentSize, _ := file.Seek(0, io.SeekEnd)

		// Бесконечный цикл для отслеживания изменений
		for {
			// Проверяем текущее состояние файла
			newStat, err := file.Stat()
			if err != nil {
				time.Sleep(100 * time.Millisecond)
				continue
			}
			newSize := newStat.Size()
			if newSize > currentSize {
				// Если файл увеличился, вычисляем сколько новых байт записано
				diff := newSize - currentSize
				outBlock := make([]byte, diff)
				// Читаем новые данные с сохраненной позиции
				file.Seek(currentSize, io.SeekStart)
				file.Read(outBlock)
				// Выводим новые строки в консоль
				fmt.Print(string(outBlock))
				// Обновляем позицию курсора
				currentSize = newSize
			} else if newSize < currentSize {
				// Если файл уменьшился, например, при удаление строки
				if newSize == 0 {
					// Если файл очистили до нуля, сбрасываемся в начало
					currentSize = 0
					file.Seek(0, io.SeekStart)
				} else {
					// Если в файле еще что-то осталось, сдвигаем курсор на его новый конец
					currentSize = newSize
					file.Seek(currentSize, io.SeekStart)
				}
			}

			time.Sleep(100 * time.Millisecond)
		}
	}
}
