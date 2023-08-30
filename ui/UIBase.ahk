

class UIBase {
	__New() {
		this.gui := Gui()
		this.window := UIWindow()
	}
}

class UIWindow {
	__New(x := 10, y := 10, width := 500, height := 250) {
		this.x := x
		this.y := y
		this.width := width
		this.height := height
		
		this._flagDictionary := {
			width: 'w',
			height: 'h'
		}

		this._flags := this.getFlags()
	}

	getFlags() {
		out := []
		keys := ObjectUtilities.keys(this)
		flagKeys := ObjectUtilities.keys(this._flagDictionary)

		for key in keys {
			if (StrSplit(key)[1] == '_' || this.%key% == 0) {
				continue
			}

			if (ArrayUtilities.indexOf(flagKeys, key) != -1) {
				out.Push(this._flagDictionary.%key% this.%key%)
			}
			else {
				out.Push(key this.%key%)
			}
		}

		return ArrayUtilities.join(out, ' ')
	}
}
