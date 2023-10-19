;? This script just holds flag data for different elements

class FlagField {
	/** 
	 * @param {String} prefix The string that comes before the value
	 * @param {String} fieldType Type of this value, default is string, bool would cause the value to apear as the key
	 * @param {String} prefix The string that comes after the value (for example a color after a "Background" flag)
	*/
	__New(prefix, fieldType := 'string', suffix := '') {
		this.prefix := prefix
		this.type := fieldType
		this.suffix := suffix
	}

	__Get(value := '') {
		out := ''
		switch this.type {
			case 'bool':
				out := (value) ? '+' this.prefix : '-' this.prefix
			default:
				out := this.prefix value this.suffix
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
	;TODO make a way for a bool value to apear as the key not the value in the flags
	window: {},
	button: {},
	text: {
		center: FlagField('center', 'bool')
	}
}

;? If the name of the class is not the same as the name of the field in flags, it will be defined here
Global flagClassPairs := {
	window: 'uiwindow',
}

getFlags(obj) {
	global
	out := []
	keys := ObjectUtilities.keys(obj)
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
	
	flagObject := flags.default.Clone()
	if (field != 'default') {
		flagObject := ObjectUtilities.merge(flagObject, flags.%field%, true)

	}

	for key, fieldDefinition in flagObject.OwnProps() {
		out.Push(fieldDefinition.__Get(obj.%key%))
	}
	flagObject := {}
	return ArrayUtilities.join(out, ' ')
}