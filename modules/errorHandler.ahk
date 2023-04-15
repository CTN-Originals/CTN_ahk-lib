
ErrorHandler(Error, exit := true, *) {
	stdErr := FormatErrorMessage(Error)
	GeneralUtillities.ValidatePath('logs\error.txt')
	try FileAppend '`n`n' stdErr "`n", "**", "UTF-8"
	try FileAppend(stdErr '`n`n', 'logs\error.txt', "UTF-8")
	if (exit) {
		ExitApp 2
	}
}

FormatErrorMessage(Error) {
	stdErr := "Error: {}`nSpecifically: {}`nCall stack:`n`n"
	stdErr := Format(stdErr, Error.Message, Error.Extra)
	stdErr .= RegExReplace(Error.Stack, " \((\d+)\)", ":$1")
	stdErr := RegExReplace(stdErr, "(.*\.ahk\:[0-9]*)", "$1`n  ")

	return stdErr
}
