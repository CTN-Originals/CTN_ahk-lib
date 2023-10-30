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
wind.x := 1920 + 4
wind.y := (1080 - 70) - wind.height - 10
wind.x := 1920 - wind.width - 15 ;? When only 1 monitor is used

Global inst := ui.getInst()
; console.log('flags: ' getFlags(inst.window))
Global btn := inst.elements.Add.Button()
Global txt := inst.elements.Add.Text()
txt.setContent('Hello World')
; console.log('flags: ' getFlags(btn))
; console.log('flags: ' getFlags(txt))
; console.log(txt)

inst.gui.SetFont('s20 cRed', 'Impact')
inst.gui.AddText('x10 y10', 'Hello World!')
inst.gui.SetFont('s20 cGreen w300', 'Verdana')
inst.gui.AddText('x10 y+10', 'Hello World!')
inst.gui.SetFont('s20 cBlue norm bold italic underline strike', '')
inst.gui.AddText('x10 y+10', 'Hello World!')
ui.show()
WinSetTransparent(100, wind.hwnd)
console.log(txt)
console.log('txt'.Base.__Class)
console.log(!!('txt'.Base.__Class))
console.log(txt)
; console.log(ui)
; console.log(inst.window.__Get()) ;? returns the hwnd

; Global btn := inst.gui.AddEdit('x10 y10 w100 h30', 'Button')
