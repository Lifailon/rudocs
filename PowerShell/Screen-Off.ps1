$Signatures = '[DllImport("user32.dll")] public static extern int PostMessage(int hWnd, int hMsg, int wParam, int lParam);'
$PowerClass = Add-Type -MemberDefinition $Signatures -Name "MonitorPower" -Namespace "Win32" -PassThru
$PowerClass::PostMessage(-1, 0x0112, 0xF170, 2)