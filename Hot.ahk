/*
Hot.ahk
@author: zYeoman
@date: 2017-09-11
@description: 个人自用AHK脚本
*/

#Include Core.ahk
Hot.Ini()

;Win10 1703 删除了 StickyNot.exe 改成了 Windows APP 
;使用Win+W
#Up::WinMaximize, A
#Down::WinMinimize, A
#Enter::ToggleWindows()
#t::ToggleTitle()

LCtrl & Space::
    InputBox, SearchTEXT,,,,,100
    if SearchTEXT 
      Run, https://www.google.com/search?hl=zh-CN&q=%SearchTEXT%
return

^!t::
;当前路径运行cmd
IfWinActive, AHK_exe Everything.exe
{
    ClipSaved := ClipboardAll
    Send ^+z
    ClipWait
    Path = %clipboard%
    Clipboard := ClipSaved
}
Else
    Path := Explorer_GetPath()
IfWinExist, AHK_pid %CMD_PID%
{
    WinActivate
    WinWaitActive, AHK_pid %CMD_PID%
    if (path!="ERROR")
    {
        Send, cd %Path%`n 
    }
}
Else
{
    if (path=="ERROR"){
        Run,  cmd /K cd /D "%UserProfile%",,, CMD_PID
    }
    else{
        Run,  cmd /K cd /D "%Path%",,, CMD_PID
    }
}
return

#IfWinActive, AHK_exe Everything.exe
^e::
;使用编辑器打开文件
	ControlGetFocus, current, A
	If(current == "EVERYTHING_LISTVIEW1") 
	{
		ClipSaved := ClipboardAll
		Send ^+c
		ClipWait
		Path = %clipboard%
		Clipboard := ClipSaved
        Send {ESC}
		run % Hot.Editor . " " . Path
	}
	Else
	{
		Suspend on
		Send {Space}
		Suspend off
	}
return
#if

#IfWinActive, AHK_exe explorer.exe
^e::
;使用编辑器打开文件
    Path := Explorer_GetSelected()
	run % Hot.Editor . " " . Path
return

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

Capslock::
;Capslock映射为ESC
Suspend on
Send, {ESC}
Suspend off
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

^!r::Reload