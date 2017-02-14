#NoEnv
#SingleInstance force
#Include, Lib/Class_SQLiteDB.ahk
DBFileName = %A_ScriptDir%\Track.DB
DB := new SQLiteDB
Sleep, 1000
If FileExist(DBFileName) {
    If !DB.OpenDB(DBFileName) {
        MsgBox, 16, SQLite Error, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
        ExitApp
}
    Sleep, 1000
}
Else {
    If !DB.OpenDB(DBFileName) {
        MsgBox, 16, SQLite Error, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
        ExitApp
    }
    Sleep, 1000
    SQL := "CREATE TABLE Track (Title, ProcessName, ProcessPath,Time,Length,PRIMARY KEY(Time ASC))"
    If !DB.Exec(SQL)
       MsgBox, 16, SQLite Error, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
    Sleep, 1000
}

WinGetTitle title, A
StringReplace, title, title,','', ALL
WinGet name, ProcessName, A
StringReplace, name, name,','', ALL
last_time := A_Now
TrackTitle := "firefox.exe, SumatraPDF.exe, Conemu64.exe, Explorer.exe"
TrackLOP:
WinGetTitle title_now, A
StringReplace, title_now, title_now,','', ALL
WinGet name_now, ProcessName, A
StringReplace, name_now, name_now,','', ALL
If (name != "") and ((name != name_now) or (InStr(TrackTitle, name_now) and (title != title_now))) {
    time_len := A_Now - last_time
    last_time := A_Now
    SQL = INSERT INTO Track VALUES('%title%','%name%','%path%','%last_time%%A_Msec%','%time_len%')`;
    If !DB.Exec(SQL)
       MsgBox, 16, SQLite Error, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
    WinGetTitle title, A
    WinGet path, ProcessPath, A
    WinGet name, ProcessName, A
    StringReplace, title, title,','', ALL
    StringReplace, path, path,','', ALL
    StringReplace, name, name,','', ALL
}
SetTimer TrackLOP, 1000
return

