# mAHKs
My Autohotkey Scripts.

## 功能简介

### `Hot.ahk`
主脚本，包括其他脚本，以及以下功能：

* Win+Up,Down: 最大最小化当前窗口
* Win+t: 去除/添加当前窗口标题栏
* Ctrl+Alt+h: 显示帮助
* RightAlt+n: 调用hwmd新增作业文件(已经没有用了)
* Win+Enter: 全屏
* Ctrl+o,Ctrl+v: 用vim打开
* Ctrl+o,Ctrl+s: 用sublime打开(已经删除)
* Win+Alt+Space: 当前目录调用Everything
* F3: 发送Win+F4 显示Conemu快捷键
* Ctrl+Alt+n: 新建文件夹
* Ctrl+Alt+t: 当前目录打开CMD
* Capslock: 映射为ESC
* Win+`: 当前窗口置顶
* Ctrl+Alt+r: 重新加载当前脚本

### `Capslocks.ahk`
CapsLock键魔改。

* CapsLock+` : 原来CapsLock的功能
* CapsLock+; : =
* CapsLock+[ : (
* CapsLock+] : )
* CapsLock+w : Ctrl+Left
* CapsLock+e : Ctrl+Right
* CapsLock+q : Alt+F4
* CapsLock+0 : End
* CapsLock+1 : Home
* CapsLock+h : Left
* CapsLock+j : Down
* CapsLock+k : Up
* CapsLock+l : Right
* CapsLock+/(Alt) : Ctrl+f/F
* CapsLock+i(Alt) : Ctrl+Enter/Shift+Enter
* CapsLock+r(Alt) : Ctrl+z/Z
* CapsLock+g(Alt) : Ctrl+Home/End
* CapsLock+x(Alt) : Del/Ctrl+Del
* CapsLock+u(Alt) : PgUp/Shift+PgUp
* CapsLock+n(Alt) : PgDown/Shift+PgDown
* CapsLock+o(Alt) : Home/Shift+Home
* CapsLock+p(Alt) : End/Shift+End
* CapsLock+d(Alt) : Backspace/Ctrl+Backspace

### `Earthlive.ahk`
类似EarthLiveSharp的工具，常驻后台。

### `Gesture.ahk`
主要用于Chrome的鼠标右键手势工具。

* 左右：标签页切换
* 上：新标签页
* 下：关闭当前标签页

### `Hotstr.ahk`
热字符串。英文字符后跟 ` 符号转换成相应中文标点。

### `Time.ahk`
番茄工作法。

* RAlt+a: 显示当前状态
* RAlt+z: 结束
* RAlt+s: 开始

### `Lib`
使用的库文件，目前主要是获取目录的库。
