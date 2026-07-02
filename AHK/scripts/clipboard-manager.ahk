; Менеджер буфера обмена
; Win + V
#HotIf
MaxItems := 500
ClipHistory := []
FilteredIndexes := []
UsedHistory := Map()
OnClipboardChange(OnClipChange)
OnClipChange(Type) {
    global ClipHistory, MaxItems
    if (Type = 1) {
        CurrentClip := A_Clipboard
        for index, text in ClipHistory {
            if (text == CurrentClip) {
                ClipHistory.RemoveAt(index)
                break
            }
        }
        ClipHistory.InsertAt(1, CurrentClip)
        if (ClipHistory.Length > MaxItems) {
            ClipHistory.Pop()
        }
    }
}

UpdateFilter(*) {
    global ClipHistory, FilteredIndexes, SearchInput, HistoryBox, UsedHistory
    SearchText := SearchInput.Text
    HistoryBox.Delete()
    FilteredIndexes := []
    for index, text in ClipHistory {
        CleanText := RegExReplace(text, "\s+", " ")
        if (SearchText = "" || InStr(CleanText, SearchText, false)) {
            IconIndex := UsedHistory.Has(text) ? "Icon2" : "Icon1"
            HistoryBox.Add(IconIndex, CleanText)
            FilteredIndexes.Push(index)
        }
    }
    if (HistoryBox.GetCount() > 0) {
        HistoryBox.Modify(1, "+Select +Focus")
    }
}

SelectAndPaste(*) {
    global ClipHistory, FilteredIndexes, FilterGui, HistoryBox, UsedHistory
    FocusedRow := HistoryBox.GetNext(0, "F")
    if (FocusedRow = 0) {
        return
    }
    RealIndex := FilteredIndexes[FocusedRow]
    SelectedText := ClipHistory[RealIndex]
    UsedHistory[SelectedText] := true
    FilterGui.Destroy()
    OnClipboardChange(OnClipChange, 0)
    A_Clipboard := SelectedText
    Send("^v")
    Sleep(100)
    OnClipboardChange(OnClipChange, 1)
}

MoveFocusToSearch(*) {
    global SearchInput, FilterGui
    if (FilterGui.FocusedCtrl != SearchInput) {
        SearchInput.Focus()
    }
}

#v::
{
    global ClipHistory, FilteredIndexes, FilterGui, SearchInput, HistoryBox
    if (ClipHistory.Length = 0) {
        MsgBox("История буфера обмена пуста.", "Менеджер буфера обмена", 64)
        return
    }
    FilterGui := Gui("+AlwaysOnTop -MaximizeBox -MinimizeBox", "Менеджер буфера обмена")
    FilterGui.SetFont("s10", "Segoe UI")
    FilterGui.Add("Text", "w400", "Фильтр:")
    SearchInput := FilterGui.Add("Edit", "w400 vSearchText")
    HistoryBox := FilterGui.Add("ListView", "w400 h300 -Multi r12 Grid -NoSortHdr -Hdr", ["Buffer"])
    HistoryBox.ModifyCol(1, 375), HistoryBox.ModifyCol(1, "AutoHdr")
    ImageListID := IL_Create(2, 1, 0)
    IL_Add(ImageListID, "shell32.dll", 1) 
    IL_Add(ImageListID, "shell32.dll", 44) 
    SendMessage(0x1003, 1, ImageListID, HistoryBox.Hwnd)
    SearchInput.OnEvent("Change", UpdateFilter)
    HistoryBox.OnEvent("DoubleClick", SelectAndPaste)
    FilterGui.OnEvent("Escape", (*) => FilterGui.Destroy())
    UpdateFilter()
    FilterGui.Show()
    HistoryBox.Focus()
    HotIfWinActive("ahk_id " FilterGui.Hwnd)
    Hotkey("Enter", SelectAndPaste, "On")    
    Loop 26
        Hotkey("~*" Chr(A_Index + 96), MoveFocusToSearch, "On")
    Loop 10
        Hotkey("~*" (A_Index - 1), MoveFocusToSearch, "On")
    Hotkey("~*Space", MoveFocusToSearch, "On")
    Hotkey("~*BackSpace", MoveFocusToSearch, "On")
}