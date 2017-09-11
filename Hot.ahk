/*
@author: zYeoman
@date: 2017-09-11
@description: 个人自用AHK脚本
*/

SetCapsLockState, AlwaysOff
Menu, Tray, Icon, H.ico
DetectHiddenWindows, on
Editor := "C:\LiberKey\Apps\Notepad++\App\Notepad++\notepad++.exe"
;Win10 1703 删除了 StickyNot.exe 改成了 Windows APP 
;使用Win+W
#Up::WinMaximize, A
#Down::WinMinimize, A
#Enter::ToggleWindows()
#t::ToggleTitle()

CapsLock & s::Suspend

LCtrl & Space::
    InputBox, SearchTEXT,,,,,100
    if SearchTEXT 
      Run, https://www.google.com/search?hl=zh-CN&q=%SearchTEXT%
return

#IfWinActive, ahk_exe Everything.exe
Space::
	ClipSaved := ClipboardAll
	Send ^+c
	ClipWait
	Path = %clipboard%
	Clipboard := ClipSaved
	run % Editor . " " . Path
return
#if
#IfWinActive, ahk_exe explorer.exe
Space::
    Path := Explorer_GetSelected()
	run % Editor . " " . Path
return
#if

#IfWinActive, ahk_exe explorer.exe
^f::
;使用Everything搜索
	path := Explorer_GetPath()
	if (path!="ERROR"){
		Send !{Space}
		WinWaitActive, Everything
		ControlSetText, Edit1, "%path%"%A_space%, A
		sleep 150
		send {end}
	}
return
^n::
;新建文件
	path := Explorer_GetPath()
	if (path!="ERROR"){
		InputBox, filename, 新文件, ,,,100
		FileAppend,, %path%\%filename%
	}
return
^+c::
;复制文件路径
	path := Explorer_GetSelected()
	if (path!="ERROR"){
		Clipboard := path
	}
return
#If

^!t::
;当前路径运行cmd
path := Explorer_GetPath()
if (path=="ERROR"){
    Run,  cmd /K cd /D "%UserProfile%",,, CMD_PID
}
else{
    Run,  cmd /K cd /D "%path%",,, CMD_PID
}
return


Capslock::
;Capslock映射为ESC
Suspend on
Send, {ESC}
Suspend off
return

Esc::
ToggleCursors()
MouseMove, 500, 200, 0
return

;==================================================
;快捷键 win+` 使当前窗口置顶
;==================================================
#`::
	WinSet, AlwaysOnTop, toggle,A
	WinGetTitle, getTitle, A
	Winget, getTop,ExStyle,A
	if (getTop & 0x8){
	TrayTip 已置顶, %getTitle%
	}else{
	TrayTip 取消置顶, %getTitle%
	}
return

ToggleWindows()
{
	WinGet,KDE_Win,MinMax,A
	if KDE_Win
	  WinRestore,A
	else
	  WinMaximize,A
	return
}

ToggleTitle()
{
	;SetTitleMatchMode, 2 ;设定ahk匹配窗口标题的模式
	winactivate,A ; 激活此窗口
	sleep, 500 ; 延时，确保
	WinSet, Style, ^0xC00000,A  ;切换标题栏
	return
}

ToggleCursors()
{
    static AndMask, XorMask, $, h_cursor, b
    ,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13 ; system cursors
    , b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13 ; blank cursors
    if ($ = "") ; init when requested or at first call
    {
        $ := "1"
        VarSetCapacity( h_cursor,4444, 1 )
        VarSetCapacity( AndMask, 32*4, 0xFF )
        VarSetCapacity( XorMask, 32*4, 0 )
        system_cursors = 32512,32513,32514,32515,32516,32642,32643,32644,32645,32646,32648,32649,32650
        StringSplit c, system_cursors, `,
        Loop %c0%
        {
            b%A_Index% := DllCall("CreateCursor", Uint, 0, Int, 0, Int, 0
            , Int, 32, Int, 32, Uint, &AndMask, Uint, &XorMask )
        }
    }

    if ($ == "1")
    {
        Loop %c0%
        {
            h_cursor := DllCall( "CopyImage", Uint,b%A_Index%, Uint,2, Int,0, Int,0, Uint,0 )
            DllCall( "SetSystemCursor", Uint,h_cursor, Uint,c%A_Index% )
        }
        $ := "0"
    }
    else
    {
        RestoreCursors()
        $ := "1"
    }
}