; Извлечение цвета
; Win + C
#c::
{
    static ColorGui := ""
    static ColorText := ""
    MouseGetPos &X, &Y
    color := PixelGetColor(X, Y)
    hexColor := "#" . SubStr(color, 3)
    A_Clipboard := hexColor 
    pureHex := SubStr(color, 3)
    if (!ColorGui) {
        ColorGui := Gui("-Caption +ToolWindow +AlwaysOnTop -DPIScale +E0x08000000")
        ColorGui.MarginX := 0
        ColorGui.MarginY := 0
        ColorText := ColorGui.Add("Text", "w130 h40 Center +0x200")
    }
    ColorGui.BackColor := pureHex
    r := Integer("0x" . SubStr(pureHex, 1, 2))
    g := Integer("0x" . SubStr(pureHex, 3, 2))
    b := Integer("0x" . SubStr(pureHex, 5, 2))
    brightness := (r * 299 + g * 587 + b * 114) / 1000
    if (brightness > 128)
        ColorText.SetFont("s10 cBlack bold q5", "Segoe UI")
    else
        ColorText.SetFont("s10 cWhite bold q5", "Segoe UI")
    ColorText.Value := hexColor
    guiWidth := 130
    guiHeight := 40
    posX := X + 15
    posY := Y + 15
    if (posX + guiWidth > A_ScreenWidth)
        posX := X - guiWidth - 5
    if (posY + guiHeight > A_ScreenHeight)
        posY := Y - guiHeight - 5
    ColorGui.Show("X" posX " Y" posY " W" guiWidth " H" guiHeight " NoActivate")
    SetTimer(() => ColorGui.Hide(), -1500)
}