;鼠标手势
#IfWinActive, ahk_exe chrome.exe
rbutton::
  minGap  = 30 ; 设定的识别阈值，大于此阈值，说明在某方向上有移动
  mousegetpos xpos1,ypos1
  Keywait, RButton, U
  mousegetpos xpos2, ypos2
  if (abs(xpos1-xpos2) < minGap and abs(ypos1-ypos2)<minGap) ; nothing 没有运动，直接输出rbutton
  send, {rbutton}
  else if (xpos1-xpos2 > minGap and abs(ypos1-ypos2)<minGap) ; left  ctrl+shift+tab
   send,  ^+{Tab}
  else if (xpos2-xpos1 > minGap and abs(ypos1-ypos2)<minGap) ; right ctrl+tab
   send, ^{Tab}
  else if (abs(xpos1-xpos2)< minGap and (ypos1-ypos2)>minGap) ; up ctrl+shift+t
    send, ^+t
  else if (abs(xpos1-xpos2)< minGap and (ypos2-ypos1)>minGap) ; down ctrl+w
    send, ^w
  ;else if (ypos2-ypos1 > minGap and (xpos1-xpos2) > minGap) ; down and left , ctrl+shift+T
  ;  send, ^+t
  ;else if (ypos2-ypos1 > minGap and (xpos2-xpos1) > minGap) ; down and right, ctrl+w
  ;  send, ^w
  ;else if (ypos1-ypos2 > minGap and (xpos2-xpos1) > minGap) ; up and right alt+f4
  ; send, !{F4}
  ;else if (ypos1-ypos2 > minGap and (xpos1-xpos2) > minGap) ; up and left nothing
  ; send, {rbutton}
  else
    send, {rbutton}
return
#IfWinActive
