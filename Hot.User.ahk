
class User_DESKTOP_ANOH053
{
	Ini()
	{
        File.TODOFile := "C:\Users\Yongwen\Nextcloud\todo.txt"
        File.exts := [".doc",".ppt",".xls"]
        Hot.Editor:="C:\src\subl\subl.exe"
        Process, Exist
        ExeList := Object()

        ; 采用Object.Insert(Index, Value)的方式，Index表示第几秒启动，Value表示程序
        ExeList.Insert(0, "C:\src\conemu\ConEmu64.exe")
        ExeList.Insert(5, "C:\Program Files\Listary\Listary.exe")
        ; ExeList.Insert(10, "Z:\Program Files (x86)\WinSshFS\WinSshFS.exe")
        ExeList.Insert(10, "Z:\Program Files (x86)\CopyQ\copyq.exe")
        ExeList.Insert(15, "E:\2portable\rainmeter\Rainmeter.exe")
        Delay := 0
        Elapse := 0

        for Seconds, Target in ExeList
        {
            Delay := (Seconds - Elapse) * 1000
            SplitPath, Target, ProcName

            ; 若进程未启动则启动，若已启动则不作任何改动
            Process, Exist, %ProcName%
            if (ErrorLevel = 0)
            {
                Sleep, %Delay%
                Run, %Target%
            }

            Elapse := ((Seconds-1)>0)?Seconds:0
        }

        Run, C:\bin\client.bat, , Hide
        Run, C:\bin\startvm.bat, , Hide

	}
}

class User_DESKTOP_1H0K4D0
{
	Ini()
	{
        File.TODOFile := "D:\Nextcloud\todo.txt"
        File.exts := [".doc",".ppt",".xls"]
		Hot.Editor:="D:\src\sublime\subl.exe"
	}
}

