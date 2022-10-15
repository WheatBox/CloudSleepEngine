myImportCopyToFilenameHead = WORKFILEPATH + FILEPATH_sleepers_emotes + gSleepersStruct.materials[materialId].filename + "\\";

var sleeperEmoteFilesNum = array_length(gSleepersStruct.materials[materialId].emotefilenames);
for(var iii = 0; iii < sleeperEmoteFilesNum; iii++) {
	var _fnameTemp = gSleepersStruct.materials[materialId].emotefilenames[iii];
	if(is_string(_fnameTemp))
	if(_fnameTemp != "") {
		MyLoadSprite(iii, myImportCopyToFilenameHead + _fnameTemp);
	}
}

