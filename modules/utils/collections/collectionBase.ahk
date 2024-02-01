OnError ErrorHandler


class CollectionBase {
	__Init(collectionType := 'BASE') {
		; OutputDebug('-------- [' collectionType '] INIT --------  `n')
		this._collectionType := collectionType
		this._prefix := (*) => StrUpper(this._collectionType)
		this._recursionStorage := [] ;? store all collections that are being stringified to compare against later
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
	stringify(coll, indent := 0, indentString := "  ", displayHolder := true, isValue := false, initialCall := true) {
		out := ''

		this._recursionStorage.Push(coll) ;? add the collection to the recursion storage

		loop (this._recursionStorage.Length - 1) { ;? loop through the recursion storage backwards
			i := this._recursionStorage.Length - A_Index
			if (this._recursionStorage[i] == coll) {
				;? if the collection is already in the recursion storage, it is a recursion
				return ' <recursion> '
			}
		}

		getBracketPair := (input) => (ObjectUtilities.isObject(input)) ? ['{', '}'] : ['[', ']']
		
		isObj := ObjectUtilities.isObject(coll) ;? to make conditions easier later
		iterable := (isObj) ? coll.OwnProps() : coll ;? Make the passed in coll iterable 
		brackets := getBracketPair(coll)
		
		if (!ObjectUtilities.isObject(iterable)) {
			OutputDebug('(' Type(this) ') ERROR: Type ' Type(iterable) ' is not enumerable`n')
			return out
		}
		if (displayHolder && initialCall) {
			out := Type(coll) ' ' brackets[1] '`n'
			indent++
		}

		lineStart := StringUtilities.repeat(indentString, indent) ;? store the start of each line in a var to access later
		maxIndex := (isObj) ? ObjOwnPropCount(coll) : iterable.Length ;? get the max index of the collection

		for key, value in iterable {
			line := lineStart ((isObj) ? key ': ' : '') ;? Start the line

			if (this.isCollection(value)) {
				;? unfold the value into the stringified string
				unfoldedValue := this.stringify(value, indent + 1, indentString, displayHolder, true, false)
				valueBrackets := getBracketPair(value)

				if (unfoldedValue == ' <recursion> ') {
					line .= valueBrackets[1] unfoldedValue valueBrackets[2]
				}
				else if (StrLen(unfoldedValue) > 0) { ;? does the value contain any content?
					line .= valueBrackets[1] '`n' unfoldedValue lineStart valueBrackets[2]
				}
				else line .= valueBrackets[1] valueBrackets[2] ;? stop the line with just the brackets to indicate an empty value collection
			}
			else line .= value ;? nothing special, just add the value to the line

			if (maxIndex != A_Index) {
				line .= ','
			}
			line .= '`n'
			
			out .= line
		}

		if (displayHolder && initialCall) {
			out .= brackets[2]
		}

		if (initialCall) { ;? if this is the initial call, reset the recursion storage
			this._recursionStorage := [] ;? clear the recursion storage
		}
		
		return out
	}
}