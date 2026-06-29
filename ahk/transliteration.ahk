; Ctrl + Alt + R
^!r::Reload

; Транслитерация
; Win + T
#t::
{
    TranslitText()
}

TranslitText() {
    SavedClip := ClipboardAll()
    A_Clipboard := ""
    Send("^c")
    if !ClipWait(0.5) {
        A_Clipboard := SavedClip
        return
    }
    rus := ["щ","Щ","ч","Ч","ш","Ш","ж","Ж","ю","Ю","я","Я","х","Х","ц","Ц","э","Э","ё","Ё","а","А","б","Б","в","В","г","Г","д","Д","е","Е","з","З","и","И","й","Й","к","К","л","Л","м","М","н","Н","о","О","п","П","р","Р","с","С","т","Т","у","У","ф","Ф","ъ","Ъ","ы","Ы","ь","Ь"]
    eng := ["shh","Shh","ch","Ch","sh","Sh","zh","Zh","ju","Ju","ja","Ja","h","H","c","C","e'","E'","jo","Jo","a","A","b","B","v","В","g","G","d","D","e","E","z","Z","i","I","j","J","k","K","l","L","m","M","n","N","o","O","p","P","r","R","s","S","t","T","u","U","f","Ф","``","``","y","Y","'","'"]
    txt := A_Clipboard
    for index, rusChar in rus {
        txt := StrReplace(txt, rusChar, eng[index])
    }
    A_Clipboard := txt
    Send("^v")
    Sleep(100)
    A_Clipboard := SavedClip
}