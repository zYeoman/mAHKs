﻿; #NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
; SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
; SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoEnv
#SingleInstance force

work := 0
relax := 0
task := ""
Times := 0
FilePath:="C:\Users\Yongwen\Nextcloud\track.txt"
Menu, Tray, Icon, stopwatch.ico,,1

; 当前状态
RAlt & a::
    if (relax > 1)
        TrayTip 正在进行, %task%
    else
        TrayTip 正在玩, 好好玩233
return
; 结束
RAlt & z::
    SetTimer, Delay, off
    SetTimer, RELAX, off
    work := 0
    relax := 0
    TrayTip 停止吧, 循环
return
; 结束番茄
RAlt & e::
work = 5
goto Delay
return
; 开始
RAlt & s::
relax := 0
work  := 0
InputBox, task, 接下来要干什么？, ,,,100
Time := GetTime()
FileAppend, %Time% - 开始 - 0 - %Task%`n, %FilePath%
Delay:
if (work = 5){
    relax := 1
    SoundPlay %A_ScriptDir%/notice.wav
    MsgBox, 6,, %task% 做完了么？
    Times+=1
    Time := GetTime()
    IfMsgBox Continue
    {
        FileAppend, %Time% - 完成 - %Times% - %Task%`n, %FilePath%
        task := ""
        Times:=0
    }
    Else IfMsgBox Cancel
    {
        InputBox, actual, 实际上做了什么？, ,,,100
        FileAppend, %Time% - 中断 - x - %actual%`n, %FilePath%
    }
    Else
    {
        FileAppend, %Time% - 继续 - %Times% - %Task%`n, %FilePath%
    }
    TrayTip Timer, 休息
    SetTimer, Delay, off
    SetTimer, RELAX, 180000
}
else{
    work++
    SetTimer, RELAX, off
    SetTimer, Delay, 300000
}
return

RELAX:
if (relax = 2){
    if (task == "")
    {
        Time := GetTime()
        InputBox, task, 接下来要干什么？, ,,,100
        FileAppend, %Time% - 开始 - 0 - %Task%`n, %FilePath%
    }
    work := 1
    TrayTip Timer, %task%
    SetTimer, RELAX, off
    SetTimer, Delay, 300000
}
else{
    relax++
    SetTimer, Delay, off
    SetTimer, RELAX, 180000
}
return
GetTime() 
{
    time = %A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec% 
    return time
}
