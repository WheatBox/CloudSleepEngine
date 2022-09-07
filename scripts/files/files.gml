#macro FILEPATH_backgrounds "\\contents\\backgrounds\\"
#macro FILEPATH_decorates "\\contents\\decorates\\"
#macro FILEPATH_beds "\\contents\\beds\\"

#macro FILEJSON_backgrounds "\\contents\\backgrounds.json"
#macro FILEJSON_decorates "\\contents\\decorates.json"
#macro FILEJSON_beds "\\contents\\beds.json"

#macro FILEJSON_scene "\\contents\\scene.json"

// #macro WORKFILEPATH ".\\packages\\" + PackName + "\\"
#macro WORKFILEPATH "F:\\CSETemp\\packages\\" + PackName + "\\"

#macro PackFileExtension ".cloudpack"

// 打开素材包后，FilePath_backgrounds = WORKFILEPATH + FilePath_backgrounds;
globalvar FilePath_backgrounds, FilePath_decorates, FilePath_beds;
FilePath_backgrounds = FILEPATH_backgrounds;
FilePath_decorates = FILEPATH_decorates;
FilePath_beds = FILEPATH_beds;

globalvar PackName;
PackName = "";

function SSingleStruct_Background(_fname = "") constructor {
	filename = _fname;
};
function SSingleStruct_Decorate(_fname = "") constructor {
	filename = _fname;
	hitbox = [];
	offset = [];
};
function SSingleStruct_Bed(_fname = "") constructor {
	filename = _fname;
	hitbox = [];
	offset = [];
};

#macro DefaultStructBackgrounds { materials : [] }
#macro DefaultStructDecorates { materials : [] }
#macro DefaultStructBeds { materials : [] }

#macro DefaultSpritesStruct { sprites : [] }

globalvar gBackgroundsStruct, gDecoratesStruct, gBedsStruct;
gBackgroundsStruct = DefaultStructBackgrounds;
gDecoratesStruct = DefaultStructDecorates;
gBedsStruct = DefaultStructBeds;

globalvar gBackgroundsSpritesStruct, gDecoratesSpritesStruct, gBedsSpritesStruct;
gBackgroundsSpritesStruct = DefaultSpritesStruct;
gDecoratesSpritesStruct = DefaultSpritesStruct;
gBedsSpritesStruct = DefaultSpritesStruct;

// Struct Scene Element
function SSceneElement(_materialId, _xPos, _yPos) constructor {
	materialId = _materialId;
	xPos = _xPos;
	yPos = _yPos;
}

globalvar gSceneStruct;
gSceneStruct = {
	left : 0,
	top : 0,
	right : 100,
	bottom : 80,
	
	// 这三个数组内存储的都会是 new SSceneElement()
	backgrounds : [],
	decorates : [],
	beds : []
}

/// @desc 由文件目录获取文件名称
///			第二个参数是是否要返回后缀
function GetNameFromFileName(filename, withExtension = true) {
	var res = filename;
	
	var dotPos = string_length(filename);
	var dotGot = false;
	
	if(withExtension) {
		dotGot = true;
	}
	
	for(var i = string_length(filename); i >= 0; i--) {
		if(string_char_at(filename, i) == "." && dotGot == false) {
			dotPos = i - 1;
			dotGot = true;
		}
		if(string_char_at(filename, i) == "\\" || string_char_at(filename, i) == "/") {
			res = string_copy(filename, i + 1, dotPos - i);
			return res;
		}
	}
	
	return res;
}

function FileNameGetPicture(_caption_ImportToWhere = "") {
	return get_open_filename_ext("图片(*.png, *.jpg, *.jpeg)|*.png;*.jpg;*.jpeg", "", program_directory, "导入图片" + ((_caption_ImportToWhere == "") ? (" 到 " + _caption_ImportToWhere) : ""));
}

function LoadCloudPack() {
	var ChildFunc_LoadSprites = function(filePath, fileJson, _gSpriteStruct, _gStructStr, _gSceneStructArr) {
		var _changed = false;
	
		var fstr = NULL;
	
		if(FileGetSize(fileJson) > 0) {
			fstr = FileRead(fileJson);
		}
	
		if(fstr != NULL) {
			// variable_global_set(_gStructStr, json_parse(fstr));
			
			var _gStruct = variable_global_get(_gStructStr);
			
			var _jsonCopyTemp = json_parse(fstr);
			if(variable_struct_exists(_jsonCopyTemp, "materials")) {
				var _jsonCopyTempMaterialsLen = array_length(_jsonCopyTemp.materials);
				for(var iJson = 0; iJson < _jsonCopyTempMaterialsLen; iJson++) {
					if(CheckStructCanBeUse(_jsonCopyTemp.materials[iJson]) == false) {
						continue;
					}
					
					_gStruct.materials[iJson] = _jsonCopyTemp.materials[iJson];
					/*
					if(variable_struct_exists(_jsonCopyTemp.materials[iJson], "filename")) {
						_gStruct.materials[iJson].filename = _jsonCopyTemp.materials[iJson].filename;
					}
					if(variable_struct_exists(_jsonCopyTemp.materials[iJson], "hitbox")) {
						_gStruct.materials[iJson].hitbox = _jsonCopyTemp.materials[iJson].hitbox;
					}
					if(variable_struct_exists(_jsonCopyTemp.materials[iJson], "offset")) {
						_gStruct.materials[iJson].offset = _jsonCopyTemp.materials[iJson].offset;
					}*/
				}
			}
			
		
			_changed = false;
		
			for(var i = 0; i < array_length(_gStruct.materials); i++) {
				var _name = _gStruct.materials[i].filename;
			
				if(FileGetSize(filePath + _name) <= 0) {
					// 删除失效文件名
					array_delete(_gStruct.materials, i, 1);
					_changed = true;
				
					// 删除失效文件名的场景物体（此时这些场景物体暂时还没有被放置
					for(var j = 0; j < array_length(_gSceneStructArr); j++) {
						if(!CheckStructCanBeUse(_gSceneStructArr[j])) {
							continue;
						}
						if(_gSceneStructArr[j].materialId == i) {
							array_delete(_gSceneStructArr, j, 1);
						}
					}
				
					// SceneElement_BackgroundsAlignAfterDelete(i, 1);
				
					i--;
					continue;
				}
			
				var _sprTemp = sprite_add(filePath + _name, 1, false, true, 0, 0);
				// 此处的 offset 和 bbox 都只是编辑器内为了拖拽而设定的，实际游戏内的值以 _gStruct 结构体内的值为准
				sprite_set_offset(_sprTemp, sprite_get_width(_sprTemp) / 2, sprite_get_height(_sprTemp) / 2);
				sprite_set_bbox_mode(_sprTemp, bboxmode_fullimage);
				array_push(_gSpriteStruct.sprites, _sprTemp);
				
				
				// 修复 offset
				if(variable_struct_exists(_gStruct.materials[i], "offset")) {
					if(array_length(_gStruct.materials[i].offset) < 2) {
						_gStruct.materials[i].offset = [sprite_get_width(_sprTemp) / 2, sprite_get_height(_sprTemp) / 2];
					}
				}
			}
		
			// 如果有删除过失效文件名，进行重新写入json
			if(_changed) {
				var _changedjson = json_stringify(_gStruct);
				FileWrite(fileJson, _changedjson);
			}
		}
	}
	
	
	
	var fscene = NULL;
	
	if(FileGetSize(WORKFILEPATH + FILEJSON_scene) > 0) {
		fscene = FileRead(WORKFILEPATH + FILEJSON_scene);
	}
	
	if(fscene != NULL) {
		gSceneStruct = json_parse(fscene);
		
		gSceneStruct[$ "backgrounds"] ??= [];
		gSceneStruct[$ "decorates"] ??= [];
		gSceneStruct[$ "beds"] ??= [];
	}
	
	
	
	ChildFunc_LoadSprites(WORKFILEPATH + FILEPATH_backgrounds, WORKFILEPATH + FILEJSON_backgrounds, gBackgroundsSpritesStruct, "gBackgroundsStruct", gSceneStruct.backgrounds);
	ChildFunc_LoadSprites(WORKFILEPATH + FILEPATH_decorates, WORKFILEPATH + FILEJSON_decorates, gDecoratesSpritesStruct, "gDecoratesStruct", gSceneStruct.decorates);
	ChildFunc_LoadSprites(WORKFILEPATH + FILEPATH_beds, WORKFILEPATH + FILEJSON_beds, gBedsSpritesStruct, "gBedsStruct", gSceneStruct.beds);



	if(1) {
		var _changedjson = json_stringify(gSceneStruct);
		FileWrite(WORKFILEPATH + FILEJSON_scene, _changedjson);
	}
	
	DebugMes([gBackgroundsStruct, gBackgroundsSpritesStruct, gSceneStruct.backgrounds]);
	DebugMes([gDecoratesStruct, gDecoratesSpritesStruct, gSceneStruct.decorates]);
	DebugMes([gBedsStruct, gBedsSpritesStruct, gSceneStruct.beds]);
}

function SaveCloudPack() {
	for(var i = 0; i < array_length(gSceneStruct.backgrounds); i++) {
		if(CheckStructCanBeUse(gSceneStruct.backgrounds[i]) == false) {
			continue;
		}
		delete gSceneStruct.backgrounds[i];
	}
	array_delete(gSceneStruct.backgrounds, 0, array_length(gSceneStruct.backgrounds));
	
	for(var i = 0; i < array_length(gSceneStruct.decorates); i++) {
		if(CheckStructCanBeUse(gSceneStruct.decorates[i]) == false) {
			continue;
		}
		delete gSceneStruct.decorates[i];
	}
	array_delete(gSceneStruct.decorates, 0, array_length(gSceneStruct.decorates));
	
	for(var i = 0; i < array_length(gSceneStruct.beds); i++) {
		if(CheckStructCanBeUse(gSceneStruct.beds[i]) == false) {
			continue;
		}
		delete gSceneStruct.beds[i];
	}
	array_delete(gSceneStruct.beds, 0, array_length(gSceneStruct.beds));
	
	for(var i = 0; i < instance_count; i++) {
		if(instance_id[i].object_index == obj_SceneElementBackground) {
			DebugMes(["Saving Background", i, instance_id[i].x]);
			if(instance_id[i].materialId >= 0 && instance_id[i].materialId < array_length(gBackgroundsSpritesStruct.sprites)) {
				array_push(gSceneStruct.backgrounds, new SSceneElement(instance_id[i].materialId, instance_id[i].x, instance_id[i].y));
			}
		}
		if(instance_id[i].object_index == obj_SceneElementDecorate) {
			DebugMes(["Saving Decorate", i, instance_id[i].x]);
			if(instance_id[i].materialId >= 0 && instance_id[i].materialId < array_length(gDecoratesSpritesStruct.sprites)) {
				array_push(gSceneStruct.decorates, new SSceneElement(instance_id[i].materialId, instance_id[i].x, instance_id[i].y));
			}
		}
		if(instance_id[i].object_index == obj_SceneElementBed) {
			DebugMes(["Saving Bed", i, instance_id[i].x]);
			if(instance_id[i].materialId >= 0 && instance_id[i].materialId < array_length(gBedsSpritesStruct.sprites)) {
				array_push(gSceneStruct.beds, new SSceneElement(instance_id[i].materialId, instance_id[i].x, instance_id[i].y));
			}
		}
	}
	
	// ArrayReverse(gSceneStruct.backgrounds);
	
	
	
	var _jsonSceneFileWriteRes;
	var _jsonStr;
	
	_jsonStr = json_stringify(gSceneStruct);
	_jsonSceneFileWriteRes = FileWrite(WORKFILEPATH + FILEJSON_scene, _jsonStr);
	if(_jsonSceneFileWriteRes != 0) {
		show_message(FILEJSON_scene + "保存失败！" + string(_jsonSceneFileWriteRes));
	}
	
	_jsonStr = json_stringify(gBackgroundsStruct);
	_jsonSceneFileWriteRes = FileWrite(WORKFILEPATH + FILEJSON_backgrounds, _jsonStr);
	if(_jsonSceneFileWriteRes != 0) {
		show_message(FILEJSON_backgrounds + "保存失败！" + string(_jsonSceneFileWriteRes));
	}
	
	_jsonStr = json_stringify(gDecoratesStruct);
	_jsonSceneFileWriteRes = FileWrite(WORKFILEPATH + FILEJSON_decorates, _jsonStr);
	if(_jsonSceneFileWriteRes != 0) {
		show_message(FILEJSON_decorates + "保存失败！" + string(_jsonSceneFileWriteRes));
	}
	
	_jsonStr = json_stringify(gBedsStruct);
	_jsonSceneFileWriteRes = FileWrite(WORKFILEPATH + FILEJSON_beds, _jsonStr);
	if(_jsonSceneFileWriteRes != 0) {
		show_message(FILEJSON_beds + "保存失败！" + string(_jsonSceneFileWriteRes));
	}
}


function CheckStructCanBeUse(_structVal) {
	if(is_struct(_structVal) == true
		&& _structVal != NULL
		&& _structVal != "null"
		&& _structVal != pointer_null
		&& _structVal != undefined
	) {
		return true;
	} else {
		return false;
	}
}
