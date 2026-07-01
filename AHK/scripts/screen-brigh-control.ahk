; Управление яркостью дисплея на мониторе
; Mouse scroll + Win + UP/DOWN on Try
#HotIf MouseIsOver("ahk_class Shell_TrayWnd")
#WheelUp::AdjustBrightness(1)
#WheelDown::AdjustBrightness(-1)

AdjustBrightness(direction) {
    static step := 5
    static MyGui := ""
    static MyProgress := ""
    static MyText := ""
    hwnd := WinExist("A")
    if !hwnd
        hwnd := WinExist("ahk_class Shell_TrayWnd")
    hMonitor := DllCall("MonitorFromWindow", "ptr", hwnd, "uint", 2, "ptr")
    if !hMonitor
        return
    if DllCall("dxva2\GetNumberOfPhysicalMonitorsFromHMONITOR", "ptr", hMonitor, "uint*", &numDevices:=0) {
        physMonitors := Buffer(numDevices * (A_PtrSize + 256))
        if DllCall("dxva2\GetPhysicalMonitorsFromHMONITOR", "ptr", hMonitor, "uint", numDevices, "ptr", physMonitors) {
            hPhysMonitor := NumGet(physMonitors, 0, "ptr")
            minBr := 0, curBr := 0, maxBr := 0
            if DllCall("dxva2\GetMonitorBrightness", "ptr", hPhysMonitor, "uint*", &minBr, "uint*", &curBr, "uint*", &maxBr) {
                newBr := curBr + (direction * step)
                if (newBr > maxBr)
                    newBr := maxBr
                if (newBr < minBr)
                    newBr := minBr
                DllCall("dxva2\SetMonitorBrightness", "ptr", hPhysMonitor, "uint", newBr)
                if (!MyGui) {
                    MyGui := Gui("-Caption +ToolWindow +AlwaysOnTop -DPIScale +E0x08000000") 
                    MyGui.BackColor := "1F1F1F" 
                    MyGui.SetFont("s10 cWhite q5", "Segoe UI") 
                    MyGui.MarginX := 15
                    MyGui.MarginY := 15
                    MyText := MyGui.Add("Text", "w250 Center", "Яркость: " newBr "%")
                    MyProgress := MyGui.Add("Progress", "w250 h6 c0078D4 Background333333", newBr) 
                }
                MyText.Value := "Яркость: " newBr "%"
                MyProgress.Value := newBr
                guiWidth := 280   
                guiHeight := 80   
                MIEX := Buffer(40 + 64, 0)
                NumPut("uint", MIEX.Size, MIEX, 0)
                if DllCall("GetMonitorInfo", "ptr", hMonitor, "ptr", MIEX) {
                    monLeft   := NumGet(MIEX, 20, "int")
                    monTop    := NumGet(MIEX, 24, "int")
                    monRight  := NumGet(MIEX, 28, "int")
                    monBottom := NumGet(MIEX, 32, "int")
                    posX := monLeft + ((monRight - monLeft) / 2) - (guiWidth / 2)
                    posY := monTop + ((monBottom - monTop) / 2) - (guiHeight / 2)
                } else {
                    posX := (A_ScreenWidth / 2) - (guiWidth / 2)
                    posY := (A_ScreenHeight / 2) - (guiHeight / 2)
                }
                MyGui.Show("X" posX " Y" posY " W" guiWidth " H" guiHeight " NoActivate")
                SetTimer(() => MyGui.Hide(), -1500)
            }
            DllCall("dxva2\DestroyPhysicalMonitors", "uint", numDevices, "ptr", physMonitors)
        }
    }
}