; #NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
; SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
; SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoEnv
#SingleInstance force

work := 0
relax := 0
times := 0
task := ""
FilePath:="C:\Users\Yongwen\Nextcloud\track.txt"
Menu, Tray, Icon, stopwatch.ico,,1


; 当前状态
RAlt & a::
    if (relax > 1)
        MsgBox 正在进行, %work% %task%
    else
        MsgBox 正在玩, 好好玩233
return
; 结束
RAlt & z::
    SetTimer, Delay, off
    SetTimer, RELAX, off
    work := 0
    relax := 0
    TrayTip 停止吧, 循环
return
; 同步番茄
RAlt & d::
    res := GetTask()
    StringSplit, Output, res, ``
    work := Output1
    task := Output2
    goto Delay
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
    task := NextTask(FilePath)
Delay:
    if (work >= 5){
        relax := 1
        SoundPlay %A_ScriptDir%/notice.wav
        MsgBox, 6,, %task% 做完了么？
        times+=1
        time := GetTime()
        IfMsgBox Continue
        {
            FileAppend, %time% - 完成 - %times% - %Task%`n, %FilePath%
            task := ""
            times:=0
        }
        Else IfMsgBox Cancel
        {
            InputBox, actual, 实际上做了什么？, ,,,100
            FileAppend, %time% - 中断 - x - %actual%`n, %FilePath%
        }
        Else
        {
            FileAppend, %time% - 继续 - %times% - %Task%`n, %FilePath%
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
            task := NextTask(FilePath)
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
GetTask()
{
    oHttp := ComObjCreate("WinHttp.Winhttprequest.5.1")
    openURL = http://localhost:5000
    Try {
        oHttp.open("GET", openURL)
        oHttp.send()
        return oHttp.responseText
    }
    Catch e{
        return 5``Wrong
    }
}
PutTask(Task)
{
    oHttp := ComObjCreate("WinHttp.Winhttprequest.5.1")
    openURL = http://localhost:5000
    Try {
        oHttp.open("PUT", openURL, false)
        data = data=%Task%
        oHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
        oHttp.send(data)
    }
    Catch e{
        return
    }
}
NextTask(FilePath)
{
    SoundPlay %A_ScriptDir%/notice.wav
    InputBox, task, 接下来要干什么？, ,,,100
    time := GetTime()
    FileAppend, %time% - 开始 - 0 - %task%`n, %FilePath%
    PutTask(task)
    return task
}
