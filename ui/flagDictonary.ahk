;? This script just holds flag data for different elements

Global flags := {
	default: {
		x: 'x',
		y: 'y',
		width: 'w',
		height: 'h',
	},
	window: {}, ;TODO make a way for a bool value to apear as the key not the value in the flags
	button: {},
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

	if (ArrayUtilities.indexOf(ObjectUtilities.keys(flags), field) == -1) {
		pairIndex := ArrayUtilities.indexOf(ObjectUtilities.values(flagClassPairs), field)
		if (pairIndex > 0) {
			field := ObjectUtilities.keys(flagClassPairs)[pairIndex]
		}
		else {
			field := 'default'
		}
	}

	flagKeys := (field != 'default') ? ObjectUtilities.keys(flags.%field%) : []
	flagValues := (field != 'default') ? ObjectUtilities.values(flags.%field%) : []
	flagKeys.Push(ObjectUtilities.keys(flags.default)*)
	flagValues.Push(ObjectUtilities.values(flags.default)*)

	for key in keys {
		flagIndex := ArrayUtilities.indexOf(flagKeys, key)
		if (flagIndex == -1 || obj.%key% == 0) {
			continue
		}
		out.Push(flagValues[flagIndex] obj.%key%)
	}

	return ArrayUtilities.join(out, ' ')
}