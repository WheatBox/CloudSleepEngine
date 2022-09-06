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

#macro DefaultStruct { filename : [] }
#macro DefaultSpritesStruct { sprites : [] }

globalvar gBackgroundsStruct, gDecoratesStruct, gBedsStruct;
gBackgroundsStruct = DefaultStruct;
gDecoratesStruct = DefaultStruct;
gBedsStruct = DefaultStruct;

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
	
	
	
#region 懒得封装了
	var _changedScene = false;
	var _changed = false;
	
	var fbackgrounds = NULL;
	
	if(FileGetSize(WORKFILEPATH + FILEJSON_backgrounds) > 0) {
		fbackgrounds = FileRead(WORKFILEPATH + FILEJSON_backgrounds);
	}
	
	if(fbackgrounds != NULL) {
		gBackgroundsStruct = json_parse(fbackgrounds);
		
		_changed = false;
		
		for(var i = 0; i < array_length(gBackgroundsStruct.filename); i++) {
			var _name = gBackgroundsStruct.filename[i];
			
			if(FileGetSize(WORKFILEPATH + FILEPATH_backgrounds + _name) <= 0) {
				// 删除失效文件名
				array_delete(gBackgroundsStruct.filename, i, 1);
				_changed = true;
				_changedScene = true;
				
				// 删除失效文件名的场景物体（此时这些场景物体暂时还没有被放置
				for(var j = 0; j < array_length(gSceneStruct.backgrounds); j++) {
					if(!CheckStructCanBeUse(gSceneStruct.backgrounds[j])) {
						continue;
					}
					if(gSceneStruct.backgrounds[j].materialId == i) {
						array_delete(gSceneStruct.backgrounds, j, 1);
					}
				}
				
				// SceneElement_BackgroundsAlignAfterDelete(i, 1);
				
				i--;
				continue;
			}
			
			var _sprTemp = sprite_add(WORKFILEPATH + FILEPATH_backgrounds + _name, 1, false, true, 0, 0);
			sprite_set_offset(_sprTemp, sprite_get_width(_sprTemp) / 2, sprite_get_height(_sprTemp) / 2);
			sprite_set_bbox_mode(_sprTemp, bboxmode_fullimage);
			array_push(gBackgroundsSpritesStruct.sprites, _sprTemp);
		}
		
		// 如果有删除过失效文件名，进行重新写入json
		if(_changed) {
			var _changedjson = json_stringify(gBackgroundsStruct);
			FileWrite(WORKFILEPATH + FILEJSON_backgrounds, _changedjson);
		}
	}
#endregion
	
#region 就这样用吧
	var fdecorates = NULL;
	
	if(FileGetSize(WORKFILEPATH + FILEJSON_decorates) > 0) {
		fdecorates = FileRead(WORKFILEPATH + FILEJSON_decorates);
	}
	
	if(fdecorates != NULL) {
		gDecoratesStruct = json_parse(fdecorates);
		
		_changed = false;
		for(var i = 0; i < array_length(gDecoratesStruct.filename); i++) {
			var _name = gDecoratesStruct.filename[i];
			
			if(FileGetSize(WORKFILEPATH + FILEPATH_decorates + _name) <= 0) {
				// 删除失效文件名
				array_delete(gDecoratesStruct.filename, i, 1);
				_changed = true;
				_changedScene = true;
				
				// 删除失效文件名的场景物体（此时这些场景物体暂时还没有被放置
				for(var j = 0; j < array_length(gSceneStruct.decorates); j++) {
					if(!CheckStructCanBeUse(gSceneStruct.decorates[j])) {
						continue;
					}
					if(gSceneStruct.decorates[j].materialId == i) {
						array_delete(gSceneStruct.decorates, j, 1);
					}
				}
				
				i--;
				continue;
			}
			
			var _sprTemp = sprite_add(WORKFILEPATH + FILEPATH_decorates + _name, 1, false, true, 0, 0);
			sprite_set_offset(_sprTemp, sprite_get_width(_sprTemp) / 2, sprite_get_height(_sprTemp) / 2);
			sprite_set_bbox_mode(_sprTemp, bboxmode_fullimage);
			array_push(gDecoratesSpritesStruct.sprites, _sprTemp);
		}
		
		// 如果有删除过失效文件名，进行重新写入json
		if(_changed) {
			var _changedjson = json_stringify(gDecoratesStruct);
			FileWrite(WORKFILEPATH + FILEJSON_decorates, _changedjson);
		}
	}
#endregion
	
#region 问题不大
	var fbeds = NULL;
	
	if(FileGetSize(WORKFILEPATH + FILEJSON_beds) > 0) {
		fbeds = FileRead(WORKFILEPATH + FILEJSON_beds);
	}
	
	if(fbeds != NULL) {
		gBedsStruct = json_parse(fbeds);
		
		_changed = false;
		for(var i = 0; i < array_length(gBedsStruct.filename); i++) {
			var _name = gBedsStruct.filename[i];
			
			if(FileGetSize(WORKFILEPATH + FILEPATH_beds + _name) <= 0) {
				// 删除失效文件名
				array_delete(gBedsStruct.filename, i, 1);
				_changed = true;
				
				// 删除失效文件名的场景物体（此时这些场景物体暂时还没有被放置
				for(var j = 0; j < array_length(gSceneStruct.beds); j++) {
					if(!CheckStructCanBeUse(gSceneStruct.beds[j])) {
						continue;
					}
					if(gSceneStruct.beds[j].materialId == i) {
						array_delete(gSceneStruct.beds, j, 1);
					}
				}
				
				i--;
				continue;
			}
			
			var _sprTemp = sprite_add(WORKFILEPATH + FILEPATH_beds + _name, 1, false, true, 0, 0);
			sprite_set_offset(_sprTemp, sprite_get_width(_sprTemp) / 2, sprite_get_height(_sprTemp) / 2);
			sprite_set_bbox_mode(_sprTemp, bboxmode_fullimage);
			array_push(gBedsSpritesStruct.sprites, _sprTemp);
		}
		
		// 如果有删除过失效文件名，进行重新写入json
		if(_changed) {
			var _changedjson = json_stringify(gBedsStruct);
			FileWrite(WORKFILEPATH + FILEJSON_beds, _changedjson);
		}
	}
#endregion

	
	if(_changedScene) {
		var _changedjson = json_stringify(gSceneStruct);
		FileWrite(WORKFILEPATH + FILEJSON_scene, _changedjson);
	}
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
	
	
	var _jsonScene = json_stringify(gSceneStruct);
	
	var _jsonSceneFileWriteRes = FileWrite(WORKFILEPATH + FILEJSON_scene, _jsonScene);
	if(_jsonSceneFileWriteRes != 0) {
		show_message("保存失败！" + string(_jsonSceneFileWriteRes));
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
