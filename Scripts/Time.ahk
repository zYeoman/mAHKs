; #NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
; SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
; SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoEnv
#NoTrayIcon
#SingleInstance force

work := 0
relax := 0


RAlt & a::
    if (relax > 1)
        TrayTip 正在进行, 工作
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
; 开始
RAlt & s::
TrayTip 开启吧, 洗脑循环
Delay:
if (work = 5){
    relax := 1
    Run, nircmd.exe speak text 25分钟了，休息一下吧！
    TrayTip Timer, 休息
    SetTimer, Delay, off
    SetTimer, RELAX, 180000
}
else{
    T := work*5
    Run, nircmd.exe speak text %T%分钟了
    work++
    SetTimer, RELAX, off
    SetTimer, Delay, 300000
}
return

RELAX:
if (relax = 2){
    Run, nircmd.exe speak text 我爱学习，学习使我快乐
    work := 1
    TrayTip Timer, 工作
    SetTimer, RELAX, off
    SetTimer, Delay, 300000
}
else{
    T := relax*3
    Run, nircmd.exe speak text 你已经休息了%T%分钟
    relax++
    SetTimer, Delay, off
    SetTimer, RELAX, 180000
}
return
