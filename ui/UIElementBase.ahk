#Include elements\button.ahk
#Include elements\text.ahk

class UIElementBase {
	__New() {
		this.list := [] ;? An Array of all the elements that this element base holds
		this.collection := {} ;? All elements sorted by type. the type is dynamically added based on the Type(element).replace('Gui.')

		this.Add := AddElement(this)
	}

	__Get(index) {
		return this.list[index]
	}

	_registerElement(element) {

	}
}

class ElementInstance {
	__Init(x := 0, y := 0, width := 0, height := 0) {
		this.x := x
		this.y := y
		this.width := width
		this.height := height

		this.hwnd := 0
	}

	__Get() {
		return this.hwnd
	}
}

class AddElement {
	__New(elementBase) {
		this.elementBase := elementBase
	}

	Button() {
		element := Button()
		this.elementBase._registerElement(element)
		return element
	}
	Text() {
		element := Text()
		this.elementBase._registerElement(element)
		return element
	}
}