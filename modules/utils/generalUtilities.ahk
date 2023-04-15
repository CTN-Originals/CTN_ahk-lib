; This file will include other utilities and might contain some general utilities

class GeneralUtillities {
	/** 
	 * This function will validate a path and create the directories if they don't exist
	 * @param path The path to validate
	 * @param relativeTo The path to validate relative to
	 * @return void
	*/
	ValidatePath(path, relativeTo := A_ScriptDir) {
		OutputDebug('Validating path: ' path ' relative to: ' relativeTo '`n')
		path := StrReplace(path, '/', '\')
		split := StrSplit(path, '\')
		file := split[split.Length]
		dirPath := StrSplit(StrReplace(path, file, ''), '/')
		currentDirPath := ''
	
		for dir in dirPath {
			OutputDebug('Checking directory: ' relativeTo '\' currentDirPath '\' dir)
			if (!DirExist(relativeTo '\' dir)) {
				DirCreate(relativeTo '\' dir)
				currentDirPath := currentDirPath '\' dir
				OutputDebug('Created directory: ' relativeTo '\' currentDirPath)
			}
			else {
				currentDirPath := currentDirPath '\' dir
			}
		}
		if (!FileExist(relativeTo '\' path)) {
			OutputDebug('Created file: ' relativeTo '\' path)
			FileAppend('', relativeTo '\' path)
		}
	}
}

class GeneralUtils extends GeneralUtillities {

}
GeneralUtillities.Base := GeneralUtillities()