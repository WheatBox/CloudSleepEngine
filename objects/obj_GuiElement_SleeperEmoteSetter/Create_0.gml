// materialMasterArr = [];
materialId = -1;

sprite = undefined;

MySSleeperEmoteStruct = function(_fname, _spr) constructor {
	filename = _fname; // 注意该处的 filename 将会包含从盘符开始的文件路径和文件名
	sprite = _spr;
};
arrSleeperEmoteStructs = [];
//for(var iii = 0; iii < array_length(gSleepersStruct.materials); iii++) {
//	arrSleeperEmoteStructs[iii] = undefined;
//}

mouseOnSleeperEmoteIndex = 0; // 当前鼠标在哪一个导入按钮上

myImportCopyToFilenameHead = "";

myDeleteButtonIns = noone;


emotesSpritesSpacing = 16;


mouseOnMe = false;

myImageMinimumWidthHeight = 128;

width = 512;

left = GuiWidth() - width;
top = 0;
right = left + width;
bottom = GuiHeight();

scrollYSpeed = 50;
scrollY = 0;


arrowXAddBegin = 16;
arrowXAddEnd = 48;



MyImportSleeperEmote = function(i_arrSleeperEmoteStructs) {
	var _fnameLongTemp = FileNameGetPicture();
	if(_fnameLongTemp == "") {
		return false;
	}
	
	var _fnameTemp = GetNameFromFileName(_fnameLongTemp, true);
	
	var _copyToFilename = myImportCopyToFilenameHead + _fnameTemp;
	var _copyRes = FileCopy(_fnameLongTemp, _copyToFilename);
	DebugMes([_fnameLongTemp, " copy to ", _copyToFilename]);
	
	if(_copyRes != 0) {
		show_message("文件复制失败！");
		return false;
	}
	
	gSleepersStruct.materials[materialId].emotefilenames[i_arrSleeperEmoteStructs] = _fnameTemp;
	SaveCloudPack();
	
	MyLoadSprite(i_arrSleeperEmoteStructs, _copyToFilename);
	
	return true;
}

MyLoadSprite = function(i_arrSleeperEmoteStructs, _fname) {
	var _sprTemp = sprite_add(_fname, 1, false, true, 0, 0);
	sprite_set_offset(_sprTemp, sprite_get_width(_sprTemp) / 2, sprite_get_height(_sprTemp) / 2);
	// sprite_set_bbox_mode(_sprTemp, DragObjBboxMode);
	
	//if(CheckStructCanBeUse(arrSleeperEmoteStructs[i_arrSleeperEmoteStructs])) {
	//	delete arrSleeperEmoteStructs[i_arrSleeperEmoteStructs];
	//}
	arrSleeperEmoteStructs[i_arrSleeperEmoteStructs] = new MySSleeperEmoteStruct(_fname, _sprTemp);
}

MyDeleteSprite = function(i_arrSleeperEmoteStructs) {
	if(CheckStructCanBeUse(arrSleeperEmoteStructs[i_arrSleeperEmoteStructs])) {
		FileRemove(myImportCopyToFilenameHead + gSleepersStruct.materials[materialId].emotefilenames[i_arrSleeperEmoteStructs]);
		
		sprite_delete(arrSleeperEmoteStructs[i_arrSleeperEmoteStructs].sprite);
		gSleepersStruct.materials[materialId].emotefilenames[i_arrSleeperEmoteStructs] = NULL;
		
		array_delete(gSleepersStruct.materials[materialId].emotefilenames, i_arrSleeperEmoteStructs, 1);
		
		SaveCloudPack();
		
		delete arrSleeperEmoteStructs[i_arrSleeperEmoteStructs];
		array_delete(arrSleeperEmoteStructs, i_arrSleeperEmoteStructs, 1);
	}
}


alarm_set(0, 1);

