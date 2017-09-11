# mAHKs
My Autohotkey Scripts.

## TODO
* Track.ahk: 增加可视化工具

## 功能简介

### `Hot.ahk`
主脚本，包括其他脚本，以及以下功能：

* Win+Up,Down: 最大最小化当前窗口
* Win+t: 去除/添加当前窗口标题栏
* Win+Enter: 全屏
* Ctrl+e: 用编辑器打开
* Ctrl+f: 当前目录调用Everything
* Ctrl+Shift+n: 新建文件夹 (Windows快捷键)
* Ctrl+n： 新建文件
* Ctrl+Alt+t: 当前目录打开CMD
* Capslock: 映射为ESC
* Win+`: 当前窗口置顶
* Ctrl+Alt+r: 重新加载当前脚本

### `Time.ahk`
番茄工作法。

* RAlt+a: 显示当前状态
* RAlt+z: 结束
* RAlt+s: 开始

### `Track.ahk`
实现ManicTime的Track Computer功能。后台自动运行。

* Table track, columns:title, processname, processpath, time, length
* Example: README.md, vim.exe, /usr/bin/vim.exe, A_NowA_Msec, 20

### `Lib`
使用的库文件，目前主要是获取目录的库和sqlite的库。
