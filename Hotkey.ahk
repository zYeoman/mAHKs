DetectHiddenWindows, on
F4::
GroupAdd, Sticky, ahk_class Sticky_Notes_Note_Window
IfWinNotExist ahk_class Sticky_Notes_Note_Window
{
    Run StikyNot.exe
    WinActivate
}
Else IfWinNotActive ahk_class Sticky_Notes_Note_Window
{
    WinShow, ahk_group Sticky
    WinActivate
}
Else
{
    WinHide, ahk_group Sticky
    WinActivate, ahk_class Shell_TrayWnd
}
Return
