Global recursionLog := false
; Global recursionStorage := []
class ConsoleBase {
	__New(name, indentStep, indentChar) {
		this.name := name
		this.settings := {
			indent: {
				step: indentStep,
				char: indentChar,
			},
			prefix: {
				enable: false,
				text: this.name,
			}
		}
		this.recursionStorage := []
	}
}

/** 
 * @param {string} name The name of the console
 * @param {number} indentStep The number of indents steps to use
 * @param {string} indentChar The character to use for indents
*/
class ConsoleInstance extends ConsoleBase {
	__New(name := '', indentStep := 2, indentChar := ' ') {
		super.__New(name, indentStep, indentChar)
		this.indentLevel := 0
		this.indent := ''
		this.singleIndent := ''

		this._validate()
	}
	_validate() {
		loop this.settings.indent.step {
			this.singleIndent .= this.settings.indent.char
		}
	}

	/** 
	 * @param {string} message The message to log
	 * @param {string} options The options to use
	*/
	log(message, options*) {
		out := this._log(message, options)
		try OutputDebug(out '`n')
		catch Error as e {
			ErrorHandler(e, false)
		}
	}

	_log(message, options*) {
		out := ''
		typeString := Type(message)
		if (InStr(typeString, 'Gui.')) {
			typeString := 'Gui' ;?? Does this cuase unexpected matches that should not be matched?
		}


		switchMatch := true
		switch typeString {
			case 'Gui':
				out := Type(message) ' ' ObjectUtilities.stringify(ObjectUtilities.getGuiObject(message)) "`n"
			default: 
				switchMatch := false
		}

		if (!switchMatch) {
			if (ArrayUtilities.isArray(message)) {
				out .=  ArrayUtilities.stringify(message)
			} 
			else if (ObjectUtilities.IsObject(message)) {
				out .= ObjectUtilities.stringify(message)
			}
			else {
				out := message
			}
		}
		
		this.appendToLog(out)
		return out
	}

	/** 
	 * @param {array} options
	 * @returns {object} an object with keys for the option name with a value
	*/
	_parseOptions(options*) {
		;TODO
	}

	appendToLog(message) {
		GeneralUtillities.ValidatePath('logs\console.txt')
		try {
			FileAppend(message '`n', 'logs\console.txt')
			; OutputDebug('Writing console log file`n')
		}
		catch Error as e {
			OutputDebug('Error writing console log file`n')
			ErrorHandler(e, false)
		}
	}

	incIndentLevel() {
		this.indentLevel++
		this.indent .= this.singleIndent
	}
	decIndentLevel() {
		this.indentLevel--
		this.indent := ''
		loop this.indentLevel {
			this.indent .= this.singleIndent
		}
	}
}
class console extends ConsoleInstance {
}
ConsoleInstance.Base := ConsoleInstance()


arr := ['apple', 'banana', 'orange', 'cherry', 'pineapple']
obj := {
	some: 'thing',
	another: 'something',
	anotherthing: 'something else',
	emptyObj: {},
	emptyArr: [],
	guiObj: Gui(),
	someObj: {
		fruits: ['apple', 'banana', 'orange'],
		; vegetables: ['carrot', 'potato', 'tomato'],
		; hobbies: ['gaming', 'coding', 'reading', 'writing'],
		friends: [
			{
				name: 'John',
				age: 20,
				hobbies: ['gaming', 'coding'],
			},
			; {
			; 	name: 'Jane',
			; 	age: 21,
			; 	hobbies: ['gaming', 'coding', 'reading', 'writing'],
			; },
			; {
			; 	name: 'Jack',
			; 	age: 22,
			; 	hobbies: ['gaming', 'coding', 'reading', 'writing'],
			; },
			; {
			; 	name: 'Jill',
			; 	age: 23,
			; 	hobbies: ['gaming', 'coding', 'reading'],
			; },
		]
	}
}
; console.log(arr)
; console.log(obj)

; ArrayUtilities.stringify(arr)
; console.log('`n')
; ObjectUtilities.stringify(obj)

recursion := {
	field: 'val',
	obj: {},
	children: [],
}
; recursion.obj := recursion
; recursion.children.Push(recursion)

arrRecursion := [
	['gaming', 'coding', 'reading'],
	['apple', 'banana', 'orange', 'cherry', 'pineapple'],
	['carreot'],
	['potato', 'tomato'],
	recursion
]
; arrRecursion.Push(recursion)
; arrRecursion.Push(arrRecursion)
; console.log(arrRecursion)
; console.log(recursion)

; obj.someObj.friends.Push(recursion)

; class classLog {
; 	__New() {
; 		this.foo := 'bar'
; 		this.b := 'c'
; 		this.a := ['orange', 'banana', 'apple']
; 	}
; }
; console.log('console: ' console.name ' ' console.settings.indent.step ' ' console.settings.indent.char ' ' console.indentLevel)
; console.log(arr)
; console.log(obj)
; console.log({name: classLog()})
; console.log(Gui().Base.__Class)
; console.log(UISettingsData())