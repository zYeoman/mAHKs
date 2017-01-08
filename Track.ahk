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
title_old := ""
last_time := A_Now
TrackLOP:
WinGetTitle title, A
WinGet path, ProcessPath, A
WinGet name, ProcessName, A
StringReplace, title, title,','', ALL
StringReplace, path, path,','', ALL
StringReplace, name, name,','', ALL
If (title != title_old) {
    time_len := A_Now - last_time
    last_time := A_Now
    SQL = INSERT INTO Track VALUES('%title_old%','%name%','%path%','%last_time%%A_Msec%','%time_len%')`;
    If !DB.Exec(SQL)
       MsgBox, 16, SQLite Error, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
    WinGetTitle tmp, A
    StringReplace, tmp, tmp,','', ALL
    If (tmp != "")
        title_old := tmp
}
SetTimer TrackLOP, 1000
return

