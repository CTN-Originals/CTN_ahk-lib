#Requires AutoHotkey v2.0

class Text extends ElementInstance {
	__New(x := 10, y := 10, width := 100, height := 30) {
		super.__Init(x, y, width, height)

		this.center := true
		this.content := ''

		this.font := Font()
	}

	/** 
	 * @description Set the content and update it right away
	*/
	setContent(input) {
		this.content := input
		this.x := this.x + 20
		this.y := this.y + 50
		this.draw()
	}
}