#Requires AutoHotkey v2.0.2
#SingleInstance Force


; LEGEND
;
; "#" is Win key
; "!" is Alt (Left-Alt?)
; "+" is Shift Key

; Create new binding with Win+Shift+L
#+l::DllCall("LockWorkStation")

Komorebic(cmd) {
    RunWait(format("komorebic.exe {}", cmd), , "Hide")
}

!q::Komorebic("close")
!m::Komorebic("minimize")

; Focus windows
#h::Komorebic("focus left")
#j::Komorebic("focus down")
#k::Komorebic("focus up")
#l::Komorebic("focus right")

!+[::Komorebic("cycle-focus previous")
!+]::Komorebic("cycle-focus next")

; Move windows
#Left::Komorebic("move left")
#Down::Komorebic("move down")
#Up::Komorebic("move up")
#Right::Komorebic("move right")

; Stack windows
#+Left::Komorebic("stack left")
#+Down::Komorebic("stack down")
#+Up::Komorebic("stack up")
#+Right::Komorebic("stack right")
#+;::Komorebic("unstack")
#+[::Komorebic("cycle-stack previous")
#+]::Komorebic("cycle-stack next")


; Resize
!=::Komorebic("resize-axis horizontal increase")
!-::Komorebic("resize-axis horizontal decrease")
!+=::Komorebic("resize-axis vertical increase")
!+_::Komorebic("resize-axis vertical decrease")

; Manipulate windows
!t::Komorebic("toggle-monocle")
!f::Komorebic("toggle-float")

; Window manager options
!+m::Komorebic("manage") ; Force komorebi to manage the focused window
!+u::Komorebic("unmanage") ; Unmanage a window that was forcibly managed
!+r::Komorebic("retile")
!p::Komorebic("toggle-pause")

; Layouts
!x::Komorebic("flip-layout horizontal")
!y::Komorebic("flip-layout vertical")

; Workspaces
!1::Komorebic("focus-workspace 0")
!2::Komorebic("focus-workspace 1")
!3::Komorebic("focus-workspace 2")
!4::Komorebic("focus-workspace 3")
!5::Komorebic("focus-workspace 4")
!6::Komorebic("focus-workspace 5")
!7::Komorebic("focus-workspace 6")
!8::Komorebic("focus-workspace 7")

; Move windows across workspaces
!+1::Komorebic("move-to-workspace 0")
!+2::Komorebic("move-to-workspace 1")
!+3::Komorebic("move-to-workspace 2")
!+4::Komorebic("move-to-workspace 3")
!+5::Komorebic("move-to-workspace 4")
!+6::Komorebic("move-to-workspace 5")
!+7::Komorebic("move-to-workspace 6")
!+8::Komorebic("move-to-workspace 7")
