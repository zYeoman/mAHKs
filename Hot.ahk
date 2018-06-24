/*
Hot.ahk
@author: zYeoman
@date: 2017-09-11
@description: ��������AHK�ű�
*/

#Include Hot.Core.ahk
Hot.Ini()
;Win10 1703 ɾ���� StickyNot.exe �ĳ��� Windows APP
;ʹ��Win+W
#Up::WinMaximize, A ;���
#Down::WinMinimize, A ;��С��
#Enter::Win.ToggleWindows() ;���/��С��
#t::Win.ToggleTitle() ;��ʾ/���ر�����
#`::Win.ToggleTop() ;�ö�/ȡ���ö�

:*:;time::  ; �����ִ�ͨ������������ ";time" �滻�ɵ�ǰ���ں�ʱ��.
FormatTime, CurrentDateTime,, yyyy-MM-dd HH:mm:ss  ; ���������� 2017-12-12 16:17:52 ����
SendInput %CurrentDateTime%
return

LCtrl & Space::Win.CommandDialog() ;�����п�

^!t::File.RunCmdHere()
Capslock & d::File.OpenTODO()
Capslock & j::Send {DOWN}
Capslock & k::Send {UP}
Capslock & h::Send {LEFT}
Capslock & l::Send {RIGHT}
Capslock & x::Send {BackSpace}
Capslock & s::Send ^s
Capslock & \::SendInput ��
Capslock & .::SendInput ��
Capslock & Enter::SendInput {End}{Enter}
Capslock & BackSpace::SendInput {End}+{Home}{BS}
Capslock & [::File.DoubleChar("[", "]")
Capslock & 9::File.DoubleChar("(", ")")
Capslock & '::File.DoubleChar("""", """")
Capslock & `;::SendInput ��
Capslock & t::File.Translate()

Capslock & c::SendInput {Home}+{End}^{Insert}

#IfWinActive, AHK_exe Everything.exe
F4::
#IfWinActive, AHK_exe explorer.exe
F4::
File.OpenFile()
WinShow ahk_id %editorID%
WinActivate ahk_id %editorID%
return
^f::File.Search()
^n::File.NewFile()
^+c::File.CopyPath()
#If

F4::
editor:=Hot.Editor
IfWinActive AHK_exe %editor%
{
    editorID:=WinExist("A")
    Send !{esc}
    WinHide
}
Else
{
    IfWinExist ahk_id %editorID%
    {
        WinShow ahk_id %editorID%
        WinActivate ahk_id %editorID%
    }
    Else
        Run % Hot.Editor
}
return


; ��Ļ�߽ǲ���
; ����OneQuick
; Left Top
#if Win.Cursor.IsPos("LT")
WheelUp::send {Volume_Up}
WheelDown::send {Volume_Down}
MButton::
keywait, MButton, u
If Win.Cursor.IsPos("LT")
    Send {Volume_Mute}
return
; Shift+���ֲ�������
; ��ʵ��
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
;Capslockӳ��ΪESC
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
