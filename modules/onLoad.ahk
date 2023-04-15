try A_Args[1]
catch {
	A_Args.Push('No-Args')
}

OutputDebug("Args: ")
for arg in A_Args {
	OutputDebug(arg " ")
}
OutputDebug("`n`n")

if (DirExist('logs')) {
	Loop Files 'logs/*.txt' {
		; OutputDebug('here')
		OutputDebug(A_LoopFileShortPath '`n')
		filePath := A_LoopFileShortPath
		FileDelete(filePath)
		FileAppend('---- ' FormatTime(A_Now, 'dd-MM yyyy | hh:mm:ss') ' ----`n`n', filePath)
	}
}