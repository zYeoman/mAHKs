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
    SQL := "CREATE TABLE Track (Title, ProcessName, ProcessPath,Time,PRIMARY KEY(Time ASC))"
    If !DB.Exec(SQL)
       MsgBox, 16, SQLite Error, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
    Sleep, 1000
}
TrackLOP:
WinGetTitle title, A
WinGet path, ProcessPath, A
WinGet name, ProcessName, A
SQL = INSERT INTO Track VALUES('%title%','%name%','%path%','%A_Now%%A_Msec%')`;
If !DB.Exec(SQL)
   MsgBox, 16, SQLite Error, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
SetTimer TrackLOP, 1000

::asdlkfghagkweweuoithsldkgjadf::adlskghahlekgjawlghkladjg
