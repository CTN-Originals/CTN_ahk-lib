OnError ErrorHandler
Global collectionRecursionStorage := []
class CollectionBase {
	__Init(collectionType := 'BASE') {
		; OutputDebug('-------- INIT --------  `n')
		;? The current recursion storage
		this._collectionType := collectionType
		this._prefix := (*) => StrUpper(this._collectionType)
	}

	/** Check if a variable is a collection (array or object)
	 * @param {any} coll The variable to check
	 * @returns {Boolean} Weather or not if it is a collection
	*/
	isCollection(coll) {
		return (ArrayUtilities.isArray(coll) || ObjectUtilities.isObject(coll))
	}

	/** 
	 * @param {Object|Array} coll The collection to stringify
	 * @param {Number} indent The number of indents to use
	 * @param {String} indentString The string to use for indents
	 * @param {Boolean} isValue Is this collection a value iside another collection?
	 * @returns {String} A string representation of the collection
	*/
	stringify(coll, indent := 0, indentString := "  ", isValue := false, initialCall := true) {
		;? tmp crude but working tostring feature
		out := []
		isObj := ObjectUtilities.isObject(coll) ;? to make conditions easier later
		iterable := (isObj) ? coll.OwnProps() : coll
		lineStart := StringUtilities.repeat(indentString, indent)
		brackets := (isObj) ? ['{', '}'] : ['[', ']']

		for key, value in iterable {
			line := lineStart ((isObj) ? key ': ' : '')

			if (this.isCollection(value)) {
				unfoldedValue := this.stringify(value, indent + 1, indentString, true, false)
				if (StrLen(unfoldedValue) == 0) {
					line .= brackets[1] brackets[2]
				}
				else {
					line .= brackets[1] '`n' unfoldedValue lineStart brackets[2]
				}
			}
			else {
				line .= value
				; OutputDebug(line '`n') ;! Debug only
			}

			line .= '`n'
			
			out.Push(line)
			; Sleep(100) ;! Debug only
		}

		return ArrayUtilities.join(out, '')
	}
}