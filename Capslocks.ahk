;;=============================Caps Lock 魔改=======================

;;====================Feng Ruohang's AHK Script=====================;;
;;===================Modified By Shines77(Guozi)====================;;
;;===================Modified By zYeoman============================;;
;;==================================================================;;
;;=========================CapsLock's Stuff=========================;;
;;==================================================================;;


;;====================== CapsLock Switcher ========================||
CapsLock & `::
GetKeyState, CapsLockState, CapsLock, T
if CapsLockState = D
    SetCapsLockState, AlwaysOff
else
    SetCapsLockState, AlwaysOn
KeyWait, ``
return

;;=============================Navigator============================||
;===========================;[] = ()
CapsLock & `;::Send, =
CapsLock & [::Send, +9
CapsLock & ]::Send, +0
CapsLock & w::Send, ^{Left}
CapsLock & e::Send, ^{Right}
Capslock & q::Send !{F4}
Capslock & 0::Send {End}
Capslock & 1::Send {Home}
;===========================;/ = Ctrl+F
CapsLock & /::
if getkeystate("alt") = 0
Send, ^f
else
Send, ^F
return

;===========================;A =  Ctrl+Enter
CapsLock & i::
if getkeystate("alt") = 0
Send ^{Enter}
else
Send ^+{Enter}
return

;===========================;R = Redo
CapsLock & r::
if getkeystate("alt") = 0
Send ^z
else
Send ^+z
return
;===========================;G = gg G
CapsLock & g::
if getkeystate("alt") = 0
Send, ^{Home}
else
Send, ^{End}
return
;===========================;D = BackSpace
CapsLock & d::
if getkeystate("alt") = 0
Send, {BS}
else
Send, ^{BS}
return
;===========================;X = Delete
CapsLock & x::
if getkeystate("alt") = 0
Send, {Del}
else
Send, ^{Del}
return
;===========================;U = PageUp
CapsLock & u::
if getkeystate("alt") = 0
Send, {PgUp}
else
Send, +{PgUp}
return
;===========================;O = Home
CapsLock & o::
if getkeystate("alt") = 0
Send, {Home}
else
Send, +{Home}
return
;===========================;P = End
CapsLock & p::
if getkeystate("alt") = 0
Send, {End}
else
Send, +{End}
return
;===========================;N = PageDown
CapsLock & n::
if getkeystate("alt") = 0
Send, {PgDn}
else
Send, +{PgDn}
return
;===========================;H = Left
CapsLock & h::
if getkeystate("alt") = 0
Send, {Left}
else
Send, +{Left}
return
;===========================;J = Down
CapsLock & j::
if getkeystate("alt") = 0
Send, {Down}
else
Send, ^+{Tab}
return
;===========================;K = UP
CapsLock & k::
if getkeystate("alt") = 0
Send, {Up}
else
Send, ^{Tab}
return
;===========================;L = Right
CapsLock & l::
if getkeystate("alt") = 0
Send, {Right}
else
Send, +{Right}
return
