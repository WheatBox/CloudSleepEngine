myImportCopyToFilenameHead = WORKFILEPATH + FILEPATH_beds_bedsleep + gBedsStruct.materials[materialId].filename + "\\";

var bedSleepFilesNum = array_length(gBedsStruct.materials[materialId].sleepfilenames);
for(var iii = 0; iii < bedSleepFilesNum; iii++) {
	var _fnameTemp = gBedsStruct.materials[materialId].sleepfilenames[iii];
	if(is_string(_fnameTemp))
	if(_fnameTemp != "") {
		MyLoadSprite(iii, myImportCopyToFilenameHead + _fnameTemp);
	}
}

