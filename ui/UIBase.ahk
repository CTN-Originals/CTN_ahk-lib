class UIBase {
	__New() {
		this.name := A_ScriptName
		this.instance := [UIInstance()]
	}
	
	;#region getters
	getInst(index := 1) {
		if (index > this.instance.Length) {
			return  this.instance[1]
		}
		return this.instance[index]
	}
	;#endregion
	
	;? Shows the main UI window by default
	show(index := 1) => this.getInst(index).show()
}

class UIInstance {
	__New() {
		this.title := A_ScriptName
		this.gui := Gui() ;? the built-in gui object from ahk2 
		this.window := UIWindow()
	}

	show() => this.window.show(this.gui, this.title)
}

class UIWindow {
	__New(x := 10, y := 10, width := 500, height := 250) {
		this.x := x
		this.y := y
		this.width := width
		this.height := height
		;TODO id
		;TODO hwnd

		this._settings := UIWindowSettings()
		
		this._flagDictionary := {
			width: 'w',
			height: 'h'
		}
		this._flags := this._getFlags()
	}

	_getFlags() {
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

	/** 
	 * @param {Gui} targetGui The gui to show
	 * @param {String} title The title of the gui
	*/
	show(targetGui, title := A_ScriptName) {
		focus := WinGetID("A") ;? Get the class of the window that is currently active

		targetGui.Title := title
		targetGui.Show(this._flags)

		;? Restore focus to the window that was active before
		;* Normally useful for testing/creating gui's to return focus to your IDE
		;! Not recommended after releasing a program to the public
		;! Default value: returnFocus := !A_IsCompiled | onTopReturnFocus := (returnFocus && !A_IsCompiled)
		if (this._settings.returnFocus && WinExist(focus)) { 
			WinActivate(focus)

			;? When focus is returned, show the gui window once again but dont steal focus from the original window
			;* This is useful when a program (like your IDE) is covering the gui's position
			if (this._settings.onTopReturnFocus) {
				targetGui.Opt('+AlwaysOnTop')
				targetGui.Opt('-AlwaysOnTop')
			}
		}
	}
}
class UIWindowSettings {
	__New() {
		this.returnFocus := !A_IsCompiled
		this.onTopReturnFocus := (this.returnFocus && !A_IsCompiled)
	}
}
