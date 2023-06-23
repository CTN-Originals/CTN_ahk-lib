
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
	}
}

/** 
 * @param {string} name The name of the console
 * @param {number} indentStep The number of indents steps to use
 * @param {string} indentChar The character to use for indents
*/
class ConsoleInstance extends ConsoleBase {
	__New(name := '', indentStep := 2, indentChar := '') {
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
	 * @param {object} options The options to use
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
		
		if (ArrUtils.IsArray(message)) {
			out .= Type(message) ArrayUtilities.stringify(message) "`n"
		} 
		else if (ObjUtils.IsObject(message)) {
			out .= Type(message) ' ' ObjUtils.stringify(message) '`n'
		} 
		else {
			out := message
		}

		this.appendToLog(out)
		return out
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


; arr := [1, 2, 3, 4, 5]
; obj := {
; 	some: 'thing',
; 	another: 'something',
; 	anotherthing: 'something else',
; 	someObj: {
; 		fruits: ['apple', 'banana', 'orange'],
; 		vegetables: ['carrot', 'potato', 'tomato'],
; 		hobbies: ['gaming', 'coding', 'reading', 'writing'],
; 		friends: [
; 			{
; 				name: 'John',
; 				age: 20,
; 				hobbies: ['gaming', 'coding', 'reading', 'writing'],
; 			},
; 			{
; 				name: 'Jane',
; 				age: 21,
; 				hobbies: ['gaming', 'coding', 'reading', 'writing'],
; 			},
; 			{
; 				name: 'Jack',
; 				age: 22,
; 				hobbies: ['gaming', 'coding', 'reading', 'writing'],
; 			},
; 			{
; 				name: 'Jill',
; 				age: 23,
; 				hobbies: ['gaming', 'coding', 'reading'],
; 			},
; 		]
; 	}
; }

; console.log('console: ' console.name ' ' console.settings.indent.step ' ' console.settings.indent.char ' ' console.indentLevel)
; console.log(arr)
; console.log(obj)
; console.log(UISettingsData())