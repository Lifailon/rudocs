; Отключение дисплея
; Ctrl + Alt + L
^!l::
{
    DllCall("user32\PostMessage", "ptr", -1, "uint", 0x0112, "ptr", 0xF170, "ptr", 2)
}