
ErrorHandler(Error, exit := true, *) {
	stdErr := "Error: {}`n`nSpecifically: {}`n`nCall stack:`n"
	stdErr := Format(stdErr, Error.Message, Error.Extra)
	stdErr .= RegExReplace(Error.Stack, " \((\d+)\)", ":$1")
	stdErr := RegExReplace(stdErr, "(.*\.ahk\:[0-9]*)", "$1`n  ")
	; if (!DirExist("logs")) {
	; 	DirCreate("logs")
	; }
	try FileAppend stdErr "`n", "**", "UTF-8"
	if (exit) {
		ExitApp 2
	}
}
