#Requires AutoHotkey v2.0

class Button extends ElementInstance {
	__New(x := 10, y := 10, width := 100, height := 30, text := 'Button') {
		this.x := x
		this.y := y
		this.width := width
		this.height := height
		
		this.text := text

		this.flagDictionary := {
			x: 'x',
			y: 'y',
			width: 'w',
			height: 'h',
		}
	}
}