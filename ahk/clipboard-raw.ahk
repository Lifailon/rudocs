; Ctrl + Alt + R
^!r::Reload

; Вставка без форматирования
; Ctrl + Shift + V
^+v::
{
    A_Clipboard := ClipboardAll()
    A_Clipboard := A_Clipboard
    Send("^v")
}