#Requires AutoHotkey v2.0

class Text extends ElementInstance {
	__New(x := 10, y := 10, width := 100, height := 30, text := 'Hello World') {
		super.__Init(x, y, width, height)
		this.center := true
		
		this.text := text
	}
}