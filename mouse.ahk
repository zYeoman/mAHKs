#IfWinActive, Clicker Heroes
#MaxThreadsPerHotkey 2

F9::

PressKey := ! PressKey

Loop
{
If ! PressKey
    Break
Click 1
Sleep 50
}
Return

#MaxThreadsPerHotkey 1
