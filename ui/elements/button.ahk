#Requires AutoHotkey v2.0

class Button extends ElementInstance {
	__New(x := 10, y := 10, width := 100, height := 30, content := 'Button') {
		super.__Init(x, y, width, height)
		
		this.content := content

		this.font := Font()
	}
}