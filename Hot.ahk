CapsHelp:="================== CapsLock 魔改===================`n"
. "xd/g  `t=   Delete,    `tBackSpace,  `tFind,  `tggG;  `n"
. "uopn  `t=   PageUp,    `tHome,  `tEnd,  `tPageDown;  `n"
. "hjkl  `t=   Left,      `tDown,  `tUp,   `tRight;     `n"
. "[]ri  `t=   (), `tredo    `t^Enter                   `n"
. "`n`n"
PromoHelp:="==================== 番茄时钟 ====================`n"
. "(R)!s  `t  Start Promoto`n"
. "(R)!a  `t  Current State`n"
. "(R)!z  `t  Stop Promoto `n"
Help:="! = Alt;    ^ = Ctrl;    # = Win;    + = Shift;     `n`n`n"
. CapsHelp
. "`n`n"
. PromoHelp
. "`n`n"
. "================== R 系列 ========================`n"
. ""
CapsOn=false
Caps=flase
ChangeFlag=0
SetCapsLockState, AlwaysOff
SetTimer EarthLive,10000
#Include, Track.ahk
EarthLive:
SetTimer EarthLive, off
#Include, Earthlive.ahk
;==================   番茄时钟    ==================
#Include, Time.ahk
;==================     热字串    ================== 
#include, Hotstr.ahk
;================== CapsLock 魔改 ==================
#Include, Capslocks.ahk
;================== Gestures ==================
#Include, Gesture.ahk
#Up::WinMaximize, A
#Down::WinMinimize, A
#t::
;SetTitleMatchMode, 2 ;设定ahk匹配窗口标题的模式
winactivate,A ; 激活此窗口
sleep, 500 ; 延时，确保
WinSet, Style, ^0xC00000,A  ;切换标题栏
return

^!h::
MsgBox, ,HELP,%Help%,10
return
CapsLock & s::Suspend
;=======================================================================
; 来自https://github.com/xxr3376/AHK-script/blob/master/shortCut.ahk
;=======================================================================
RAlt & n::
  path := Explorer_GetPath()
  Run ,python2 E:\6script\hwmd.py,%path%,Hide
return

#Enter::
WinGet,KDE_Win,MinMax,A
if KDE_Win
  WinRestore,A
else
  WinMaximize,A
return

;==================================================
; 快捷键Ctrl+o开始打开
; Ctrl+o Ctrl+s 用sublime打开
; Ctrl+o Ctrl+v 用gvim打开
;==================================================
ClearOpenFlag:
  OpenFlag := 0
  return
^o::
WinGet, process, processName, % "ahk_id" WinExist("A")
if (process=="explorer.exe"){
  path := Explorer_GetSelected()
}
else if (process=="Explorer.EXE"){
  path := Explorer_GetSelected()
}
else if (process=="Everything.exe"){
  ClipSaved := ClipboardAll
  Send ^+c
  ClipWait
  path = %clipboard%
  Clipboard := ClipSaved
}
else{
  Suspend On
  Send ^o
  Suspend Off
  return
}
SetTimer, ClearOpenFlag, 500
OpenFlag = 1
return
^v::
if (OpenFlag==1){
  SetTimer, ClearOpenFlag, off
  OpenFlag = 0
  Run, "C:\Windows\vim.bat" "--remote-silent" "%path%"
}
else{
  Suspend On
  Send, ^v
  Suspend Off
}
return

#!Space::
path := Explorer_GetPath()
if (path=="ERROR"){
    Send !{Space}
}
else{
    Send !{Space}
    WinWaitActive, Everything
    ControlSetText, Edit1, "%path%"%A_space%, A
    sleep 150
    send {end}
}
return

;==================================================
;快捷键F3显示CMD窗口
;==================================================
; conemu has its own hotkeys
; #IfWinActive, ahk_exe ConEmu64.exe
; conemu quake mode!! Wonderful!!
F3::Send #{F4}

~^!n::
path := Explorer_GetPath()
if (path!="ERROR")
{
    InputBox, filename,, ,,,100
    FileAppend,, %path%\%filename%
}
else
    send ^!n
return

;^!a::
;h := DllCall("C:\Program Files (x86)\Tencent\WeChat\PrScrn.dll\PrScrn")
;if ErrorLevel
;  MsgBox %ErrorLevel%
;return

;==================================================
;快捷键 ctrl+alt+t 当前路径运行cmd
;==================================================
^!t::
path := Explorer_GetPath()
if (path=="ERROR"){
    Run,  cmd /K cd /D "C:/user",,, CMD_PID
}
else{
    Run,  cmd /K cd /D "%path%",,, CMD_PID
}
return


;==================================================
;映射Capslock为Esc键，Shift+Capslock为原来的Capslock
;==================================================

Capslock::
;suspend to prevent calling esc
if Caps=false
    Caps = true
else
    Caps = false
Suspend on
Send, {ESC}
Suspend off
return

Esc::
;会把动态鼠标变成静态。
;TODO:
SystemCursor(-1)
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

^!r::
SystemCursor(1)
Reload
return


SystemCursor(OnOff=1) ; INIT = "I","Init"; OFF = 0,"Off"; TOGGLE = -1,"T","Toggle"; ON = others
{
    static AndMask, XorMask, $, h_cursor
    ,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13 ; system cursors
    , b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13 ; blank cursors
    , h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12,h13 ; handles of default cursors
    if (OnOff = "Init" or OnOff = "I" or $ = "") ; init when requested or at first call
    {
        $ = h ; active default cursors
        VarSetCapacity( h_cursor,4444, 1 )
        VarSetCapacity( AndMask, 32*4, 0xFF )
        VarSetCapacity( XorMask, 32*4, 0 )
        system_cursors = 32512,32513,32514,32515,32516,32642,32643,32644,32645,32646,32648,32649,32650
        StringSplit c, system_cursors, `,
        Loop %c0%
        {
            h_cursor := DllCall( "LoadCursor", "uint",0, "uint",c%A_Index% )
            h%A_Index% := DllCall( "CopyImage", "uint",h_cursor, "uint",2, "int",0, "int",0, "uint",0 )
            b%A_Index% := DllCall("CreateCursor","uint",0, "int",0, "int",0
            , "int",32, "int",32, "uint",&AndMask, "uint",&XorMask )
        }
    }
    if (OnOff = 0 or OnOff = "Off" or $ = "h" and (OnOff < 0 or OnOff = "Toggle" or OnOff = "T"))
    $ = b ; use blank cursors
    else
    $ = h ; use the saved cursors

    Loop %c0%
    {
    h_cursor := DllCall( "CopyImage", "uint",%$%%A_Index%, "uint",2, "int",0, "int",0, "uint",0 )
    DllCall( "SetSystemCursor", "uint",h_cursor, "uint",c%A_Index% )
    }
}
