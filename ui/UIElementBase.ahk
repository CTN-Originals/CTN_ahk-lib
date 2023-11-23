#Include elements\button.ahk
#Include elements\text.ahk

class UIElementBase {
	__New(parent) {
		this.parent := parent
		this.list := [] ;? An Array of all the elements that this element base holds
		this.collection := {} ;? All elements sorted by type. the type is dynamically added based on the Type(element).replace('Gui.')

		this.Add := AddElement(this)
	}

	__Get(index) {
		return this.list[index]
	}

	registerElement(element) {
		this.list.Push(element)
		elementName := element.Base.__Class
		subCollection := ObjectUtilities.hasKey(this.collection, elementName)
		if (!subCollection) {
			console.log(elementName)
			this.collection.%elementName% := [element]
		}
		else {
			this.collection.%elementName%.Push(element)
		}
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

	setParent(input) {
		this.parent := input
	}
}

class AddElement {
	__New(elementBase) {
		this.elementBase := elementBase
	}

	_validateNew(element) {
		element.setParent(this.elementBase)
		this.elementBase.registerElement(element)
	}

	/* @returns {Button} The created text element */
	Button() {
		element := Button()
		this._validateNew(element)
		return element
	}

	/* @returns {Text} The created text element */
	Text() {
		element := Text()
		this._validateNew(element)
		return element
	}
}


class Font {
	/** 
	 * @param {String} name The name of the font
	 * @param {Integer} size The size of the font
	 * @param {String} color The color of the font in hex (without the '#')
	*/
	__New(name := 'Verdana', size := 12, color := 'FFFFFF') {
		this.name := name
		this.size := size
		this.color := color
		this.width := 0 ;? 0 is null and it causes the width flag to be omited

		this.style := {
			bold: false,
			italic: false,
			underline: false,
			strike: false,
		}
	}

	/** 
	 * @description Apply the font to the target instance
	 * @param {UIInstance} target The target UI Instance
	*/
	Apply(target) {
		target.gui.SetFont()
	}
}