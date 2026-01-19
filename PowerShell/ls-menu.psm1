# Импортируем модуль PS-Menu в текущую сессию из репозитория GitHub
$module = "https://raw.githubusercontent.com/chrisseroka/ps-menu/master/ps-menu.psm1"
Invoke-Expression $(Invoke-RestMethod $module)

function ls-menu {
	param (
		$startDir = "C:\"
	)
	clear
	# Проверяем, что мы не находимся в root директории (исключить возврат назад)
	if ([System.IO.Path]::GetPathRoot($startDir) -eq $startDir) {
		$select = menu @(
			@($(Get-ChildItem $startDir).name)
		)
	}
	else {
		$select = menu @(
			@("..")+@($(Get-ChildItem $startDir).name)
		)
	}
	# Если выбрали возврат назад, то забираем только путь у стартовой директории
	if ($select -eq "..") {
		$backPath = [System.IO.Path]::GetDirectoryName($startDir)
		ls-menu $backPath
	}
	else {
		# Проверяем, что выбрали директорию
		if ($(Test-Path "$startDir\$select" -PathType Container)) {
			# Если выбрали директорию, к стартовому пути добавляем выбранное имя директории
			ls-menu "$startDir\$select"
		}
		else {
			ls-menu $startDir
		}
	}
}