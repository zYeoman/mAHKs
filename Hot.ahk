/*
Hot.ahk
@author: zYeoman
@date: 2017-09-11
@description: 个人自用AHK脚本
*/

#Include Hot.Core.ahk
Hot.Ini()

;Win10 1703 删除了 StickyNot.exe 改成了 Windows APP
;使用Win+W
#Up::WinMaximize, A ;最大化
#Down::WinMinimize, A ;最小化
#Enter::Win.ToggleWindows() ;最大/最小化
#t::Win.ToggleTitle() ;显示/隐藏标题栏
#`::Win.ToggleTop() ;置顶/取消置顶

LCtrl & Space::Win.CommandDialog() ;打开运行框

^!t::File.RunCmdHere()
Capslock & t::File.OpenTODO()

#IfWinActive, AHK_exe Everything.exe
^e::
#IfWinActive, AHK_exe explorer.exe
^e::
File.OpenFile()
return
^f::File.Search()
^n::File.NewFile()
^+c::File.CopyPath()
#If

#IfWinActive ahk_class ConsoleWindowClass
^l::SendInput {Raw}clear`n

; Ctrl + U, 清空当前输入的命令
^u::Send ^{Home}
#If

Capslock::
;Capslock映射为ESC
Suspend on
IfWinActive AHK_exe notepad.exe
{
    Send, ^s
    Send, !{F4}
}
Send, {ESC}
Suspend off
return

^!r::Reload