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
wind.x := 1920 - wind.width - 15
wind.y := (1080 - 70) - wind.height - 10

ui.show()
console.log(ui)