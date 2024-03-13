#Include ../../ui/UIBase.ahk ;? Not in inport.ahk yet but will be in there once its functional
#Include ../../import.ahk ;! Edit this later to be more specific and not include unused scripts foroptimal testing

#SingleInstance Force
#Warn All, Off
#ErrorStdOut 'UTF-8'
OnError ErrorHandler

Persistent(true)
console.log(' ')

Global ui := UIBase()

Global inst := ui.getInst(1)
Global wind := inst.window
; wind.x := 1920 + 4
; wind.x := (- + wind.width - 10) ;? When only there is a second monitoron the left
wind.y := (1080 - 70) - wind.height - 10
wind.x := 1920 - wind.width - 15 ;? When only 1 monitor is used

Global inst := ui.getInst()
btnRect := Rect(10, 10)
Global btn := inst.elements.Add.Button()
txtRect := Rect({x: 2, y: 40})
Global txt := inst.elements.Add.Text()

txt.font := Font('Arial', 20, 'ff0000')
txt.content := 'Hello World!'
btn.y := 40

inst.elements.drawAll()

; txt.setContent('Hello World')
; console.log('flags win: ' getFlags(inst.window))
; console.log('flags btn: ' getFlags(btn))
; console.log('flags txt: ' getFlags(txt))


; inst.gui.SetFont('s20 cRed', 'Impact')
; inst.gui.AddText('x10 y10', 'Hello World!')
; inst.gui.SetFont('s20 cGreen w300', 'Verdana')
; inst.gui.AddText('x10 y+10', 'Hello World!')
; inst.gui.SetFont('s20 cBlue norm bold italic underline strike', '')
; inst.gui.AddText('x10 y+10', 'Hello World!')

ui.show()
; inst.gui.Minimize()
WinSetTransparent(100, wind.hwnd)
; inst.gui.Minimize()

; console.log(txt)
; console.log(inst.elements)

; console.log(ui)
; console.log(inst.window.__Get()) ;? returns the hwnd