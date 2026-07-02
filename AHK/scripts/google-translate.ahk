; Переводчик текста
; Ctrl + Q
#HotIf
global CurrentMode := "en-ru"
global TranslateText := ""
global TranslateGui := ""
global InputTextCtrl := ""
global OutputTextCtrl := ""
global ModeTextCtrl := ""
InitTranslateGUI() {
    global TranslateGui, InputTextCtrl, OutputTextCtrl, ModeTextCtrl
    if (TranslateGui)
        return
    TranslateGui := Gui(, "Google Translate")
    TranslateGui.SetFont("s10", "Segoe UI")
    TranslateGui.Add("Text", "x10 y10 w120 h20", "Введите текст:")
    InputTextCtrl := TranslateGui.Add("Edit", "x10 y30 w460 h80 vInputText")
    TranslateGui.Add("Button", "x10 y120 w40 h26", "⇄").OnEvent("Click", SwapLanguages)
    ModeTextCtrl := TranslateGui.Add("Text", "x60 y123 w200 h20", "Английский → Русский")
    TranslateGui.Add("Button", "x10 y160 w100 h30", "Перевести").OnEvent("Click", TranslateNow)
    TranslateGui.Add("Button", "x120 y160 w100 h30", "Копировать").OnEvent("Click", CopyTranslation)
    TranslateGui.Add("Button", "x230 y160 w100 h30", "Очистить").OnEvent("Click", ClearAll)
    TranslateGui.Add("Text", "x10 y200 w120 h20", "Перевод:")
    OutputTextCtrl := TranslateGui.Add("Edit", "x10 y220 w460 h80 +ReadOnly vOutputText")
    TranslateGui.OnEvent("Escape", (*) => TranslateGui.Hide())
    TranslateGui.OnEvent("Close", (*) => TranslateGui.Hide())
}

SwapLanguages(*) {
    global CurrentMode, ModeTextCtrl
    if (CurrentMode = "en-ru") {
        CurrentMode := "ru-en"
        ModeTextCtrl.Value := "Русский → Английский"
    } else {
        CurrentMode := "en-ru"
        ModeTextCtrl.Value := "Английский → Русский"
    }
}

TranslateNow(*) {
    global CurrentMode, InputTextCtrl, OutputTextCtrl, TranslateText
    savedText := InputTextCtrl.Value
    if (savedText = "") {
        MsgBox("Отсутствует текст для перевода")
        return
    }
    OutputTextCtrl.Value := "Загрузка перевода..."
    if (CurrentMode = "en-ru") {
        sourceCode := "en"
        targetCode := "ru"
    } else {
        sourceCode := "ru"
        targetCode := "en"
    }
    translation := GoogleTranslate(savedText, targetCode, sourceCode)
    if (translation != "") {
        OutputTextCtrl.Value := translation
        TranslateText := translation
    } else {
        OutputTextCtrl.Value := ""
        TranslateText := ""
    }
}

GoogleTranslate(str, tl := "ru", sl := "auto") {
    encodedText := UriEncode(str)
    url := "https://translate.googleapis.com/translate_a/single?client=gtx&sl=" . sl . "&tl=" . tl . "&dt=t&q=" . encodedText
    try {
        http := ComObject("WinHttp.WinHttpRequest.5.1")
        http.Open("GET", url, false)
        http.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36")
        http.Send()
        response := http.ResponseText
        if (InStr(response, "[[")) {
            startPos := InStr(response, "[[[") + 3
            if (startPos > 3) {
                startPos := InStr(response, '"', false, startPos) + 1
                if (startPos > 1) {
                    endPos := InStr(response, '"', false, startPos)
                    if (endPos > startPos) {
                        translation := SubStr(response, startPos, endPos - startPos)
                        translation := DecodeUnicode(translation)
                        return translation
                    }
                }
            }
        }
        return ""
    } catch {
        return ""
    }
}

UriEncode(str) {
    f := "UTF-8"
    buf := Buffer(StrPut(str, f) * 2)
    len := StrPut(str, buf, f)
    out := ""
    Loop len - 1 {
        c := NumGet(buf, A_Index-1, "UChar")
        if ((c >= 0x30 && c <= 0x39) || (c >= 0x41 && c <= 0x5A) || (c >= 0x61 && c <= 0x7A))
            out .= Chr(c)
        else
            out .= "%" . Format("{:02X}", c)
    }
    Return out
}

CopyTranslation(*) {
    global TranslateText
    if (TranslateText != "") {
        A_Clipboard := TranslateText
        ToolTip("Переведённый текст скопирован!")
        SetTimer(() => ToolTip(), -1500)
    } else {
        MsgBox("Отсутствует текст для копирования")
    }
}

ClearAll(*) {
    global InputTextCtrl, OutputTextCtrl, TranslateText
    InputTextCtrl.Value := ""
    OutputTextCtrl.Value := ""
    TranslateText := ""
}

DecodeUnicode(str) {
    pos := 1
    out := ""
    while (pos <= StrLen(str)) {
        if (SubStr(str, pos, 2) = "\u") {
            code := "0x" . SubStr(str, pos+2, 4)
            out .= Chr(Integer(code))
            pos += 6
        } else {
            out .= SubStr(str, pos, 1)
            pos += 1
        }
    }
    Return out
}

$^q::
{
    global CurrentMode, TranslateGui, InputTextCtrl, ModeTextCtrl
    InitTranslateGUI()
    OldClipboard := ClipboardAll()
    A_Clipboard := ""
    Send("{Ctrl Up}{Shift Up}")
    Sleep(50)
    Send("^c")
    if !ClipWait(1) {
        A_Clipboard := OldClipboard
        MsgBox("Не удалось скопировать выделенный текст")
        return
    }
    CleanText := A_Clipboard
    RegExReplace(CleanText, "i)[a-z]", "", &CountEN)
    TotalSymbols := StrLen(RegExReplace(CleanText, "\s", ""))
    if (TotalSymbols > 0) {
        if ((CountEN / TotalSymbols) > 0.4) {
            CurrentMode := "en-ru"
            ModeTextCtrl.Value := "Английский → Русский"
        } else {
            CurrentMode := "ru-en"
            ModeTextCtrl.Value := "Русский → Английский"
        }
    }
    InputTextCtrl.Value := CleanText
    TranslateGui.Show("w480 h320")
    TranslateNow()
    A_Clipboard := OldClipboard
}