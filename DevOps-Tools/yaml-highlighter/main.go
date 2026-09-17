package main

import (
	"strings"
)

var colorMap = map[string]string{
	"red":       "\033[31m",
	"green":     "\033[32m",
	"yellow":    "\033[33m",
	"blue":      "\033[34m",
	"purple":    "\033[35m",
	"lightBlue": "\033[36m",
	"reset":     "\033[0m",
	"error":     "\033[41m\033[30m",
}

func YamlColor(yamlData string) string {
	lineArr := strings.Split(yamlData, "\n")
	var lineColorArr []string
	for _, line := range lineArr {
		trimSpaceLine := strings.TrimSpace(line)
		checkVar := strings.Split(trimSpaceLine, ":")
		switch {
		// 1. Comments
		case len(trimSpaceLine) >= 1 && trimSpaceLine[0] == '#':
			line = colorMap["green"] + line + colorMap["reset"]
		// 2. YAML array
		case len(trimSpaceLine) >= 1 && trimSpaceLine[0] == '-':
			if len(trimSpaceLine) > 2 && trimSpaceLine[1] != ' ' {
				line = colorMap["error"] + line + colorMap["reset"]
			} else {
				line = strings.Replace(line, "-", colorMap["purple"]+"-"+colorMap["reset"], 1)
			}
		// 3. YAML variables
		case len(checkVar) >= 2:
			// 3.1. Key
			if strings.Contains(checkVar[0], " ") {
				line = colorMap["error"] + line
			} else {
				line = colorMap["blue"] + line
			}
			line = strings.Replace(line, ":", colorMap["reset"]+":", 1)
			// 3.2. Value
			if len(checkVar[1]) >= 1 && checkVar[1][0] != ' ' {
				line = strings.Replace(line, ":", ":"+colorMap["error"], 1)
				line += colorMap["reset"]
			} else {
				if len(checkVar) == 2 {
					checkVarValue := strings.TrimSpace(checkVar[1])
					if len(checkVarValue) >= 1 && !strings.Contains(checkVarValue, " ") {
						dataType := getDataType(checkVarValue)
						if dataType != "string" {
							line = strings.Replace(line, ":", ":"+colorMap[dataType], 1)
							line += colorMap["reset"]
						}
					}
				}
			}
		}
		lineColorArr = append(lineColorArr, line)
	}
	colorData := strings.Join(lineColorArr, "\n")
	return colorData
}

func getDataType(value string) string {
	switch {
	case isInt(value):
		return "lightBlue"
	case value == "true" || value == "false":
		return "yellow"
	}
	return "string"
}

func isInt(value string) bool {
	if len(value) == 0 {
		return false
	}
	for i, char := range value {
		if i == 0 && char == '-' {
			continue
		}
		if char < '0' || char > '9' {
			return false
		}
	}
	return true
}
