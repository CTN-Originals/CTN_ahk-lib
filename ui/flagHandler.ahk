;? This script just holds flag data for different elements

class FlagField {
	/** 
	 * @param {String} prefix The string that comes before the value
	 * @param {String} fieldType Type of this value, default is string, bool would cause the value to apear as the key
	*/
	__New(prefix, fieldType := 'default') {
		this.prefix := prefix
		this.type := fieldType
	}

	__Get(value := '') {
		out := ''
		switch this.type {
			case 'bool':
				out := (value) ? '+' this.prefix : '-' this.prefix
			case 'noValue':
				out := this.prefix
			default:
				out := this.prefix value
		}
		return out
	}
}

Global flags := {
	default: {
		x: FlagField('x'),
		y: FlagField('y'),
		width: FlagField('w'),
		height: FlagField('h'),
	},
	window: {},
	font: {
		size: FlagField('s'),
		color: FlagField('c'),
		width: FlagField('w'),
		style: {
			bold: FlagField('bold', 'noValue'),
			italic: FlagField('italic', 'noValue'),
			underline: FlagField('underline', 'noValue'),
			strike: FlagField('strike', 'noValue'),
		}
	},
	button: {},
	text: {
		center: FlagField('center', 'bool')
	},
}

;? If the name of the class is not the same as the name of the field in flags, it will be defined here
Global flagClassPairs := {
	window: 'uiwindow',
}

getFlags(obj) {
	global
	field := StrLower(Type(obj))

	if (!ObjectUtilities.hasKey(flags, field)) {
		pairIndex := ArrayUtilities.indexOf(ObjectUtilities.values(flagClassPairs), field)
		if (pairIndex > 0) {
			field := ObjectUtilities.keys(flagClassPairs)[pairIndex]
		}
		else {
			field := 'default'
		}
	}
	
	flagObject := (field != 'font') ? flags.default.Clone() : {}
	if (field != 'default') {
		flagObject := ObjectUtilities.merge(flagObject, flags.%field%, true)
	}
	
	flagArray := resolveFlagObject(obj, flagObject)
	flagObject := {}
	return ArrayUtilities.join(flagArray, ' ')
}


/** Puts all flags together from the flag object into an array
 * @param {Object} obj the object to get the value from with the key
 * @param {Object} flagObject the flag object conataining all the flag fields
*/
resolveFlagObject(obj, flagObject) {
	out := []
	for key, fieldDefinition in flagObject.OwnProps() {
		;? if obj doesnt contain key, key is likely unset and should be omited
		if (!ObjectUtilities.hasKey(obj, key))
			continue

		;? if type is not flag field, its likely an object containing more flag fields
		if (Type(fieldDefinition) != 'FlagField') {
			out.Push(resolveFlagObject(obj.%key%, fieldDefinition)*)
		}
		else {
			out.Push(fieldDefinition.__Get(obj.%key%))
		}
	}

	return out
}