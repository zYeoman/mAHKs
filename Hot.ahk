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
Capslock & d::File.OpenTODO()
Capslock & j::Send {DOWN}
Capslock & k::Send {UP}
Capslock & h::Send {LEFT}
Capslock & l::Send {RIGHT}
Capslock & x::Send {Del}
Capslock & \::SendInput 、
Capslock & .::SendInput .
Capslock & Enter::SendInput {End}{Enter}
Capslock & BackSpace::SendInput {End}+{Home}{BS}
Capslock & [::File.DoubleChar("[", "]")
Capslock & 9::File.DoubleChar("(", ")")
Capslock & '::File.DoubleChar("""", """")
Capslock & `;::SendInput ：
Capslock & t::File.Translate()

Capslock & c::SendInput {Home}+{End}^{Insert}

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

; 屏幕边角操作
; 来自OneQuick
; Left Top
#if Win.Cursor.IsPos("LT")
WheelUp::send {Volume_Up}
WheelDown::send {Volume_Down}
MButton::
keywait, MButton, u
If Win.Cursor.IsPos("LT")
    Send {Volume_Mute}
return
; Shift+滚轮操作亮度
; 不实现
RButton Up::Win.WinMenu.Show()
#If
; Right Top
#if Win.Cursor.IsPos("RT")
wheelup::send {media_prev}
wheeldown::send {media_next}
mbutton::
keywait, mbutton, u
if not Win.Cursor.IsPos("RT")
	return
send {media_play_pause}
return
#if
; Left or Right
#if Sys.Cursor.IsPos("L") || Sys.Cursor.IsPos("R")
wheelup::send {pgup}
wheeldown::send {pgdn}
+wheelup::send {pgup}{pgup}{pgup}{pgup}{pgup}
+wheeldown::send {pgdn}{pgdn}{pgdn}{pgdn}{pgdn}
^+wheelup::send {home}
^+wheeldown::send {end}
#if
; ///////////////
; Top
#if Sys.Cursor.IsPos("T")
wheelup::Sys.Win.GotoPreTab()
wheeldown::Sys.Win.GotoNextTab()
#if
; ///////////////
; Bottom
#if Win.Cursor.IsPos("B")
wheelup::send ^#{Left}
wheeldown::send ^#{Right}
mbutton::
keywait, mbutton, u
if not Sys.Cursor.IsPos("B")
	return
send #{tab}
return
#if

#IfWinActive ahk_class ConsoleWindowClass
^l::SendInput {Raw}clear`n
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
IfWinActive AHK_exe ici.exe
{
    Send, !{F4}
}
Send, {ESC}
Suspend off
return

^!r::Reload