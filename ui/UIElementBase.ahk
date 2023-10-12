#Include elements\button.ahk

class UIElementBase {
	__New() {
		this.list := [] ;? An Array of all the elements that this element base holds
		this.collection := {} ;? All elements sorted by type. the type is dynamically added based on the Type(element).replace('Gui.')

		this.Add := AddElement(this)
	}

	__Get(index) {
		return this.list[index]
	}
}

class ElementInstance {
	__New() {
		this.hwnd := 0
	}

	__Get() {
		return this.hwnd
	}
}

class AddElement {
	__New(base) {
		this.base := base
	}
}