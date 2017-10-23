/*
Core.ahk
@author: zYeoman
@date: 2017-09-11
@description: 自用库，修改自OneQuick
*/

Goto CORE_LABLE

#Persistent
#SingleInstance force
#MaxHotkeysPerInterval 200
#MaxThreads, 255
#MaxThreadsPerHotkey, 20
 
#Include, *i Hot.User.ahk
; ////////////////////////////////////

class Hot
{
	static ProgramName := "Hot"
	static icon_default := "Icon/fire.ico"
	static icon_suspend := "Icon/fire_blue.ico"
	static icon_pause := "Icon/fire_not.ico"
	static icon_suspend_pause := "Icon/fire_blue_not.ico"
    static Editor = 

	Ini()
	{
		SetBatchLines, -1   ; maximize script speed!
		SetWinDelay, -1
        SetCapsLockState, AlwaysOff
        DetectHiddenWindows, on
		CoordMode, Mouse, Screen
		CoordMode, ToolTip, Screen
		CoordMode, Menu, Screen

        if(this.Editor = "")
		{
			; %systmeroot% can't give to this.Editor directly
			defNotepad = %SystemRoot%\notepad.exe
			this.Editor := defNotepad
		}
        
		; Menu Tray
		this.SetIcon(this.icon_default)
        Menu, Tray, Nostandard
		Menu, Tray, Tip, % this.ProgramName
        Menu, Tray, Add, Open, Sub_Hot_ListLine
        Menu, Tray, Add, Spy, Sub_Hot_RunSpy
        Menu, Tray, Add
		Menu, Tray, Add, Reload, Sub_Hot_Reload
		Menu, Tray, Add, Exit, Sub_Hot_Exit
		Menu, Tray, Add
		Menu, Tray, Add, Suspend Hotkey, Sub_Hot_ToggleSuspend
		Menu, Tray, Add, Pause Thread, Sub_Hot_TogglePause
        Menu, Tray, Add
        
        Menu, Tray, Default, Suspend Hotkey
		Menu, Tray, Click, 1
        ; Create a Hot.User.ahk file
		; and add a User_ComputerName class
		user_str := "User_" A_ComputerName
		StringReplace, user_str, user_str, - , _, All
		user_str := RegExReplace(user_str, "[^a-zA-Z0-9_]")
		if IsFunc(user_str ".Ini")
		{
			%user_str%.Ini()
		}
		Else
		{
			str := "`nclass " user_str "`n{`n`tIni()`n`t{`n`n`t}`n}`n`n"
			FileAppend, % str, Hot.User.ahk
			MsgBox, 0x44, Hello, It's your first time run this script, open Readme file?
			IfMsgBox, Yes
			{
				RunWait % Hot.Editor . " " . A_ScriptDir . "\README.md"
			}
			Run % Hot.Editor . " " . A_ScriptDir . "\Hot.User.ahk"
		}
        
        Run, %A_ScriptDir%\Scripts\Track.ahk
        
	}

	SetIcon(ico)
	{
		Menu, Tray, Icon, %ico%,,1
	}

	AutoSetIcon()
	{
		if !A_IsSuspended && !A_IsPaused
			this.SetIcon(this.icon_default)
		Else if !A_IsSuspended && A_IsPaused
			this.SetIcon(this.icon_pause)
		Else if A_IsSuspended && !A_IsPaused
			this.SetIcon(this.icon_suspend)
		Else if A_IsSuspended && A_IsPaused
			this.SetIcon(this.icon_suspend_pause)
	}

}

class Win
{

    ID()
    {
        WinGet, winID, ID, A
        return % winID
    }

    Title(winID := "")
    {
        if (winID == "")
            winID := this.ID()
        WinGetTitle, title, ahk_id %winID%
        return % title
    }

    Class(winID := "")
    {
        if (winID == "")
            winID := this.ID()
        WinGetClass, class, ahk_id %winID%
        return % class
    }

    Path(winID := "")
    {
        if (winID == "")
            winID := this.ID()
        WinGet, path, ProcessPath, ahk_id %winID%
        return % path
    }
    
    CommandDialog()
    {
        InputBox, command,,,,,100
        if command
        {
            if ErrorLevel
            {
                filename := File.TODOFile
                if InStr(command, "* ") == 1
                    FileAppend, %command%`n, %filename%
            }
            else
            {
                run(command)
            }
        }
        return
    }
    
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
    
    ToggleTop()
    {
        WinSet, AlwaysOnTop, toggle,A
        WinGetTitle, getTitle, A
        Winget, getTop,ExStyle,A
        if (getTop & 0x8)
        {
            TrayTip 已置顶, %getTitle%
        }
        else
        {
            TrayTip 取消置顶, %getTitle%
        }
        return
    }
    
    ExplorerSelect(path)
    {
        explorerpath:= "explorer /select," path
        Run, %explorerpath%
    }
    
    Show(winID := "")
    {
        if (winID == "")
            winID := this.ID()
        WinShow, ahk_id %winID%
    }

    Hide(winID := "")
    {
        if (winID == "")
            winID := this.ID()
        WinHide, ahk_id %winID%
    }
    Transparent(moveto := "", winID := "")
    {
        if (winID == "")
            winID := this.ID()
        WinGet, Transparent, Transparent, ahk_id %winID%
        If (Transparent = "")
            Transparent = 255
        if (moveto = "")
            Return % floor(Transparent/2.55)
        Transparent_New := moveto * 2.55
        If (Transparent_New < 51)
            Transparent_New = 51
        If (Transparent_New > 254 )
            Transparent_New = 255
        WinSet, Transparent, %Transparent_New%, ahk_id %winID%
    }
    
	class Cursor
	{
		static CornerPixel := 8
		static info_switch := 0

		CornerPos(X := "", Y := "", cornerPix = "")
		{
			if (X = "") or (Y = "")
			{
				MouseGetPos, X, Y
			}
			if(cornerPix = "")
			{
				cornerPix := this.CornerPixel
			}
			; Multi Monitor Support
			SysGet, MonitorCount, MonitorCount
			Loop, % MonitorCount
			{
				SysGet, Mon, Monitor, % A_Index
				if(X>=MonLeft && Y>= MonTop && X<MonRight && Y<MonBottom)
				{
					str =
					if ( X < MonLeft + cornerPix )
						str .= "L"
					else if ( X >= MonRight - cornerPix)
						str .= "R"
					if ( Y < MonTop + cornerPix )
						str .= "T"
					else if ( Y >= MonBottom - cornerPix)
						str .= "B"
					return % str
				}
			}
			return ""
		}

		IsPos(pos, cornerPix = "")
		{
			StringUpper, pos, pos
			pos_now := this.CornerPos("", "", cornerPix)
			if (pos_now == "") && (pos == "")
				Return
			if StrLen(pos_now) == 1
				Return % (pos_now == pos)
			Else
				pos_now2 := SubStr(pos_now,2,1) SubStr(pos_now,1,1)
			Return ((pos_now == pos) || (pos_now2 == pos))
		}
	}
    ; //////////////////////////////////////////////////////////////////////////
    ; //////////////////////////////////////////////////////////////////////////
    ; //////////////////////////////////////////////////////////////////////////
    /*

    */
    class WinMenu
    {
        static InfoObj := {}
        static HideIDs := {}
        static ini_registered := 0

        Ini()
        {
            if (this.ini_registered == 1)
                Return
            OneQuick.OnExit("Sub_WinMenu_OnExit")
            this.ini_registered := 1
        }

        Show(ID := "")
        {
            if (ID == "")
                ID := Win.ID()
            Title := Win.Title(ID)
            Path := Win.Path(ID)
            Cls := Win.Class(ID)
            this.InfoObj[1] := Title
            this.InfoObj[2] := Path
            this.InfoObj[3] := ID
            this.InfoObj[4] := Cls
            Title := SubStr(Title, 1, 150)
            Path := SubStr(Path, 1, 150)
            try
            {
                Menu, windowMenu, DeleteAll
            }
            Try
            {
                Menu, windowMenu_ShowWinMenu, DeleteAll
            }
            Try
            {
                Menu, WinMenu_Trans, DeleteAll
            }
            Loop, 9
            {
                Menu, WinMenu_Trans, Add, % (110-A_Index*10)`%, Sub_WinMenu_Trans
            }
            Trans := Sys.Win.Transparent()
            Try
            {
                Menu, WinMenu_Trans, Check, %Trans%`%
            }
            Menu, windowMenu, Add, Transparent: %Trans%`%, :WinMenu_Trans
            Menu, windowMenu, Add, Open Location, Sub_WinMenu_ExplorerSelect
            Menu, windowMenu, Add
            Menu, windowMenu, Add, Title:     %Title%, Sub_WinMenu_CopyToClipboard
            Menu, windowMenu, Add, Path:    %Path%, Sub_WinMenu_CopyToClipboard
            Menu, windowMenu, Add, ID:        %ID%, Sub_WinMenu_CopyToClipboard
            Menu, windowMenu, Add, Class:   %Cls%, Sub_WinMenu_CopyToClipboard
            Menu, windowMenu, Add
            Menu, windowMenu, Add, Hide Window, Sub_WinMenu_HideWindow
            HideIDs_IsVoid := 1
            For k, v in this.HideIDs
            {
                Menu, windowMenu_ShowWinMenu, Add, % k, Sub_WinMenu_ShowWindow
                HideIDs_IsVoid := 0
            }
            if (HideIDs_IsVoid)
            {
                Menu, windowMenu_ShowWinMenu, Add, <empty>, Sub_WinMenu_ShowWindow
                Menu, windowMenu_ShowWinMenu, Disable, <empty>
            }
            Menu, windowMenu, Add, Show Window, :windowMenu_ShowWinMenu
            Menu, windowMenu, Show
        }
    }
}

Sub_WinMenu_Trans:
Win.Transparent(ceil(110-A_ThisMenuItemPos*10))
Return

Sub_WinMenu_ExplorerSelect:
Win.ExplorerSelect(Win.WinMenu.InfoObj[2])
Return

Sub_WinMenu_CopyToClipboard:
clip := Win.WinMenu.InfoObj[A_ThisMenuItemPos - 4]
Clipboard = %clip%
Return

Sub_WinMenu_HideWindow:
id := Win.WinMenu.InfoObj[3]
WinHide, ahk_id %id%
Win.WinMenu.HideIDs[id "  " Win.WinMenu.InfoObj[1]] := id
Return

Sub_WinMenu_ShowWindow:
id := Win.WinMenu.HideIDs[A_ThisMenuItem]
Win.Show(id)
Win.WinMenu.HideIDs.Remove(A_ThisMenuItem)
Return

Sub_WinMenu_OnExit:
Loop Win.WinMenu.HideIDs
{
    id := Win.WinMenu.HideIDs[A_Index]
    Win.Show(id)
}
Return

class File
{
    static TODOFile = 
    pCMD := ""
    pTODO := ""
    
    OpenTODO()
    {
        if(this.TODOFile == "")
		{
			this.TODOFile := %A_ScriptDir% + "/todo.txt"
		}
        tFilename := this.TODOFile
        run %tFilename%
    }
    
    OpenFile(FilePath="")
    {
        if(FilePath=="")
            FilePath := this.GetPath(1)
        if (FilePath!="ERROR")
        {
            Send,{Esc}
            run % Hot.Editor . " " . FilePath
        }
    }
    
    GetPath(fileflag=0)
    ;fileflag=0  输出文件夹路径
    ;fileflag=1  输出文件路径orERROR
    {
        IfWinActive, AHK_exe Everything.exe
        {
            ClipSaved := ClipboardAll
            Send ^+c
            ClipWait
            Path = %clipboard%
            Clipboard := ClipSaved
        }
        Else IfWinActive, AHK_exe explorer.exe
        {
            Path := Explorer_GetSelected()
            if (Path=="ERROR" || Instr(Path, ";"))
            {
                Path := Explorer_GetPath()
            }
            if InStr(Path, ";")
                return "ERROR"
        }
        Else
            return "ERROR"
        FileGetAttrib, t_Attr, %Path%
        If (fileflag==1 && Instr(t_Attr, "D"))
            return "ERROR"
        If (Not InStr(t_Attr,"D")) && fileflag==0
        {
            SplitPath, Path, , PathDir
            return PathDir
        }
        return Path
    }
    
    RunCmdHere()
    {
        path := this.GetPath()
        IfWinActive, ahk_EXE Everything.exe
            Send {Esc}
        t_pCMD := this.pCMD
        IfWinExist, AHK_PID %t_pCMD%
        {
            WinActivate
            WinWaitActive, AHK_pid %t_pCMD%
            if (path!="ERROR")
            {
                Send, cd %Path%`n
            }
        }
        Else
        {
            if (Path=="ERROR"){
                Run,  cmd /K cd /D "%UserProfile%",,, t_pCMD
            }
            else{
                Run,  cmd /K cd /D "%Path%",,, t_pCMD
            }
            this.pCMD := t_pCMD
        }
        return
    }
    
    Search()
    {
        ;使用Everything搜索
        Path := this.GetPath()
        if (Path!="ERROR")
        {
            Send !{Space}
            WinWaitActive, Everything
            ControlSetText, Edit1, "%Path%"%A_space%, A
            sleep 150
            send {end}
        }
        return
    }
    
    NewFile()
    {
        ;新建文件
        Path := this.GetPath()
        if (Path!="ERROR"){
            InputBox, filename, 新文件, ,,,100
            FileAppend,, %Path%\%filename%
        }
        return
    }
    
    CopyPath()
    {
    ;复制文件路径
        Path := Explorer_GetSelected()
        if (Path!="ERROR"){
            Clipboard := Path
        }
    return
    }
    
    DoubleChar(char1, char2="")
    {
        if(char2=="")
        {
            char2:=char1
        }
        charLen:=StrLen(char2)
        selText:=this.getSelText()
        ClipboardOld:=ClipboardAll
        if(selText)
        {
            Clipboard:=char1 . selText . char2
            SendInput, +{insert}
        }
        else
        {
            Clipboard:=char1 . char2
            SendInput, +{insert}{left %charLen%}
        }
        Sleep, 100
        Clipboard:=ClipboardOld
        Return

    }
    Translate()
    {
        selText:=this.getSelText()
        if(selText)
        {
            ydTranslate(selText)
        }
        else
        {
            ClipboardOld:=ClipboardAll
            Clipboard:=""
            SendInput, ^{Left}^+{Right}^{insert}
            ClipWait, 0.05
            selText:=Clipboard
            ydTranslate(selText)
            Clipboard:=ClipboardOld
        }
        Return

    }
    getSelText()
    {
        ClipboardOld:=ClipboardAll
        Clipboard:=""
        SendInput, ^{insert}
        ClipWait, 0.1
        if(!ErrorLevel)
        {
            selText:=Clipboard
            Clipboard:=ClipboardOld
            StringRight, lastChar, selText, 1
            if(Asc(lastChar)!=10) ;如果最后一个字符是换行符，就认为是在IDE那复制了整行，不要这个结果
            {
                return selText
            }
        }
        Clipboard:=ClipboardOld
        return
    }

}

ydTranslate(txt)
{
    Run, C:\src\ici.exe %txt%
}

Sub_Hot_RunSpy:
    run %A_ScriptDir%/AU3_Spy.exe
Return

Sub_Hot_ListLine:
    ListLines
Return

Sub_Hot_Exit:
    msgbox, 0x40034, % Hot.ProgramName, Sure to Exit?
    IfMsgBox Yes
        ExitApp
return

Sub_Hot_Reload:
    Reload
return

; --------------------------
Sub_Hot_ToggleSuspend:
    if A_IsSuspended
    {
        Menu, Tray, Default, Pause Thread
        Menu, Tray, UnCheck, Suspend Hotkey
        Suspend, Off
    }
    else
    {
        Menu, Tray, Default, Pause Thread
        Menu, Tray, Check, Suspend Hotkey
        Suspend, On
    }
    Hot.AutoSetIcon()
Return

Sub_Hot_TogglePause:
    if A_IsPaused
    {
        Menu, Tray, Default, Suspend Hotkey
        Menu, Tray, UnCheck, Pause Thread
        Pause, Off
    }
    else
    {
        Menu, Tray, Default, Suspend Hotkey
        Menu, Tray, Check, Pause Thread
        ; pause will not run SetIcon(), so set icon First
        Hot.SetIcon(A_IsSuspended ? Hot.icon_suspend_pause : Hot.icon_pause)
        Pause, On
    }
    Hot.AutoSetIcon()
Return


; //////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////
/*
three useful function
the command pass to run() can be:
1. a label or a function name, even "class.func"
2. a system cmd/run command, like "dir", or "http://google.com"
3. search
*/

t(str := "")
{
	if (str != "")
		ToolTip, % str
	Else
		ToolTip
}

run(command)
{
    if(InStr(command, " "))
    {
        Run, https://www.google.com/search?hl=zh-CN&q=%command%
	}
    else if(IsLabel(command))
	{
		Gosub, %command%
	}
	else if (IsFunc(command))
	{
		Array := StrSplit(command, ".")
		If (Array.MaxIndex() >= 2)
		{
			cls := Array[1]
			cls := %cls%
			Loop, % Array.MaxIndex() - 2
			{
				cls := cls[Array[A_Index+1]]
			}
			return cls[Array[Array.MaxIndex()]]()
		}
		Else
		{
			return %command%()
		}
	}
	Else
	{
		if(RegExMatch(command, "^https?://"))
		{
			brw := OneQuick.Browser
			if(brw == "")
				run, %command%
			Else if(brw == "microsoft-edge:")
				run, %brw%%command%
			Else
				run, %brw% %command%
			Return
		}
		else if(RegExMatch(command, "i)av(\d+)", avn))
		{
			run("http://www.bilibili.com/video/av" avn1)
			return
		}
		Try
		{
			run, %command%
			Return
		}
		Catch
		{
			if(IsFunc("run_user"))
			{
				func_name = run_user
				%func_name%(command)
			}
			else
            {
				Run, https://www.google.com/search?hl=zh-CN&q=%command%
            }
        }
	}
}

RunArr(arr)
{
	Loop, % arr.MaxIndex()
	{
		run(arr[A_Index])
	}
}


CORE_LABLE:
