; Переключить раскладку для выделенного текста
; Win + Shift
~#LShift Up::
{
    ConvertLayout()
}

ConvertLayout() {
    SavedClip := ClipboardAll()
    A_Clipboard := ""
    Send("^c")
    if !ClipWait(0.5) {
        A_Clipboard := SavedClip
        return
    }
    eng := "qwertyuiop[]asdfghjkl;'zxcvbnm,.QWERTYUIOP{}ASDFGHJKL:`"ZXCVBNM<>"
    rus := "йцукенгшщзхъфывапролджэячсмитьбюЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ"
    result := ""
    loop parse, A_Clipboard
    {
        char := A_LoopField
        if (idx := InStr(eng, char, true))
            result .= SubStr(rus, idx, 1)
        else if (idx := InStr(rus, char, true))
            result .= SubStr(eng, idx, 1)
        else
            result .= char
    }
    A_Clipboard := result
    Send("^v")
    Sleep(100)
    A_Clipboard := SavedClip
}