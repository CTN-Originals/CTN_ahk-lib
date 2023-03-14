try A_Args[1]
catch {
	A_Args.Push('No-Args')
}

OutputDebug("Args: ")
for arg in A_Args {
	OutputDebug(arg " ")
}
OutputDebug("`n`n")