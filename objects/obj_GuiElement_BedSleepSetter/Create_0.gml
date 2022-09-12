// materialMasterArr = [];
materialId = -1;

sprite = undefined;

MySBedSleepStruct = function(_fname, _spr) constructor {
	filename = _fname; // 注意该处的 filename 将会包含从盘符开始的文件路径和文件名
	sprite = _spr;
};
arrBedSleepStructs = [];
for(var iii = 0; iii < array_length(gSleepersStruct.materials); iii++) {
	arrBedSleepStructs[iii] = undefined;
}

mouseOnBedSleepIndex = 0; // 当前鼠标在哪一个导入按钮上

myImportCopyToFilenameHead = "";

myDeleteButtonIns = noone;


sleepersSpritesSpacing = 16;


mouseOnMe = false;

myImageMinimumWidthHeight = 128;

width = 768;

left = GuiWidth() - width;
top = 0;
right = left + width;
bottom = GuiHeight();

scrollYSpeed = 50;
scrollY = 0;


arrowXAddBegin = 16;
arrowXAddEnd = 48;



MyCreateSurfSleepersSprites = function() {
	var len = array_length(gSleepersStruct.materials);
	if(len <= 0) {
		return surface_create(1, 1);
	}
	
	
	var surfTemp = surface_create(
		myImageMinimumWidthHeight + arrowXAddEnd,
		(myImageMinimumWidthHeight + sleepersSpritesSpacing) * len
	);
	
	SaveDrawSettings();
	
	draw_set_alpha(1);
	draw_set_color(c_white);
	surface_set_target(surfTemp);
	for(var i = 0; i < len; i++) {
		var _sprTemp = gSleepersSpritesStruct.sprites[i];
		
		var _scalesTemp;
		if(sprite_get_width(_sprTemp) > sprite_get_height(_sprTemp)) {
			_scalesTemp = SetSizeLockAspect_Width_Generic(myImageMinimumWidthHeight, sprite_get_width(_sprTemp));
		} else {
			_scalesTemp = SetSizeLockAspect_Height_Generic(myImageMinimumWidthHeight, sprite_get_height(_sprTemp));
		}
		
		var _yTemp = (i * (myImageMinimumWidthHeight + sleepersSpritesSpacing)) + myImageMinimumWidthHeight / 2;
		draw_sprite_ext(
			_sprTemp, 0
			, myImageMinimumWidthHeight / 2
			, _yTemp
			, _scalesTemp[0]
			, _scalesTemp[1]
			, 0, c_white, 1.0
		);
		
		draw_arrow(myImageMinimumWidthHeight + arrowXAddBegin, _yTemp, myImageMinimumWidthHeight + arrowXAddEnd, _yTemp, 16);
	}
	surface_reset_target();
	
	LoadDrawSettings();
	
	return surfTemp;
}
surfSleepersSprites = MyCreateSurfSleepersSprites();


MyImportBedSleep = function(i_arrBedSleepStructs) {
	var _fnameLongTemp = FileNameGetPicture();
	if(_fnameLongTemp == "") {
		return false;
	}
	
	var _fnameTemp = GetNameFromFileName(_fnameLongTemp, true);
	
	var _copyToFilename = myImportCopyToFilenameHead + _fnameTemp;
	var _copyRes = FileCopy(_fnameLongTemp, _copyToFilename);
	DebugMes([_fnameLongTemp, " copy to ", _copyToFilename]);
	
	if(_copyRes != 0) {
		show_message("文件复制失败！\n请确认文件目录或文件名中没有使用中文");
		return false;
	}
	
	gBedsStruct.materials[materialId].sleepfilenames[i_arrBedSleepStructs] = _fnameTemp;
	SaveCloudPack();
	
	MyLoadSprite(i_arrBedSleepStructs, _copyToFilename);
	
	return true;
}

MyLoadSprite = function(i_arrBedSleepStructs, _fname) {
	var _sprTemp = sprite_add(_fname, 1, false, true, 0, 0);
	sprite_set_offset(_sprTemp, sprite_get_width(_sprTemp) / 2, sprite_get_height(_sprTemp) / 2);
	// sprite_set_bbox_mode(_sprTemp, DragObjBboxMode);
	
	if(CheckStructCanBeUse(arrBedSleepStructs[i_arrBedSleepStructs])) {
		delete arrBedSleepStructs[i_arrBedSleepStructs];
	}
	arrBedSleepStructs[i_arrBedSleepStructs] = new MySBedSleepStruct(_fname, _sprTemp);
}

MyDeleteSprite = function(i_arrBedSleepStructs) {
	if(CheckStructCanBeUse(arrBedSleepStructs[i_arrBedSleepStructs])) {
		FileRemove(myImportCopyToFilenameHead + gBedsStruct.materials[materialId].sleepfilenames[i_arrBedSleepStructs]);
		
		sprite_delete(arrBedSleepStructs[i_arrBedSleepStructs].sprite);
		gBedsStruct.materials[materialId].sleepfilenames[i_arrBedSleepStructs] = NULL;
		
		SaveCloudPack();
		
		delete arrBedSleepStructs[i_arrBedSleepStructs];
	}
}


alarm_set(0, 1);

