#Include ../../ui/UIBase.ahk ;? Not in inport.ahk yet but will be in there once its functional
#Include ../../import.ahk ;! Edit this later to be more specific and not include unused scripts foroptimal testing

#SingleInstance Force
#Warn All, Off
#ErrorStdOut 'UTF-8'
OnError ErrorHandler

Persistent(true)
console.log(' ')

Global ui := UIBase()

t := 'Title'
xGui := Gui(, 'test')
; console.log(xGui)
; console.log(xGui.%t%)
; console.log(Type(xGui))
; console.log(ObjectUtilities.keys(xGui.OwnProps()))

; console.log(ui)

