#macro FILEPATH_sleepers "\\contents\\sleepers\\"
#macro FILEPATH_backgrounds "\\contents\\backgrounds\\"
#macro FILEPATH_decorates "\\contents\\decorates\\"
#macro FILEPATH_beds "\\contents\\beds\\"

#macro FILEPATH_sleepers_emotes "\\contents\\sleepers\\emotes\\"
#macro FILEPATH_beds_bedsleep "\\contents\\beds\\bedsleep\\"

#macro FILEJSON_sleepers "\\contents\\sleepers.json"
#macro FILEJSON_backgrounds "\\contents\\backgrounds.json"
#macro FILEJSON_decorates "\\contents\\decorates.json"
#macro FILEJSON_beds "\\contents\\beds.json"

#macro FILEJSON_scene "\\contents\\scene.json"

#macro FILEJSON_TextboxPlaceHolders "\\contents\\TextboxPlaceHolders.json"

#macro WORKFILEPATH_default ".\\packages\\" + PackName + "\\"

// #macro WORKFILEPATH ".\\packages\\" + PackName + "\\"
// #macro WORKFILEPATH "F:\\CSETemp\\packages\\" + PackName + "\\"
globalvar WORKFILEPATH;
WORKFILEPATH = working_directory; // 随便填个目录先占着位置

#macro PackFileExtension ".cloudpack"


globalvar PackName;
PackName = "";

function SSingleStruct_Sleeper(_fname = "") constructor {
	filename = _fname;
	offset = [];
	emotefilenames = [];
};
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
	sleepfilenames = [];
};

#macro DefaultStructSleepers { materials : [] }
#macro DefaultStructBackgrounds { materials : [] }
#macro DefaultStructDecorates { materials : [] }
#macro DefaultStructBeds { materials : [] }

#macro DefaultSpritesStruct { sprites : [] }

globalvar gSleepersStruct, gBackgroundsStruct, gDecoratesStruct, gBedsStruct;
gSleepersStruct = DefaultStructSleepers;
gBackgroundsStruct = DefaultStructBackgrounds;
gDecoratesStruct = DefaultStructDecorates;
gBedsStruct = DefaultStructBeds;

globalvar gSleepersSpritesStruct, gBackgroundsSpritesStruct, gDecoratesSpritesStruct, gBedsSpritesStruct;
gSleepersSpritesStruct = DefaultSpritesStruct;
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
	
	// 这几个数组内存储的都会是 new SSceneElement()
	sleepers : [],
	backgrounds : [],
	decorates : [],
	beds : [],
	
	// 默认背景 materialId
	defaultBackground : -1,
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
	return get_open_filename_ext("图片(*.png, *.jpg, *.jpeg)|*.png;*.jpg;*.jpeg", "", "", "导入图片" + ((_caption_ImportToWhere != "") ? (" 到 " + _caption_ImportToWhere) : ""));
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
				sprite_set_bbox_mode(_sprTemp, DragObjBboxMode);
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
		
		gSceneStruct[$ "sleepers"] ??= [];
		gSceneStruct[$ "backgrounds"] ??= [];
		gSceneStruct[$ "decorates"] ??= [];
		gSceneStruct[$ "beds"] ??= [];
		
		gSceneStruct[$ "defaultBackground"] ??= -1;
	}
	
	
	
	ChildFunc_LoadSprites(WORKFILEPATH + FILEPATH_sleepers, WORKFILEPATH + FILEJSON_sleepers, gSleepersSpritesStruct, "gSleepersStruct", gSceneStruct.sleepers);
	ChildFunc_LoadSprites(WORKFILEPATH + FILEPATH_backgrounds, WORKFILEPATH + FILEJSON_backgrounds, gBackgroundsSpritesStruct, "gBackgroundsStruct", gSceneStruct.backgrounds);
	ChildFunc_LoadSprites(WORKFILEPATH + FILEPATH_decorates, WORKFILEPATH + FILEJSON_decorates, gDecoratesSpritesStruct, "gDecoratesStruct", gSceneStruct.decorates);
	ChildFunc_LoadSprites(WORKFILEPATH + FILEPATH_beds, WORKFILEPATH + FILEJSON_beds, gBedsSpritesStruct, "gBedsStruct", gSceneStruct.beds);
	
	
	for(var i = 0; i < array_length(gSleepersStruct.materials); i++) {
		gSleepersStruct.materials[i][$ "emotefilenames"] ??= [];
	}
	for(var i = 0; i < array_length(gBedsStruct.materials); i++) {
		gBedsStruct.materials[i][$ "sleepfilenames"] ??= [];
	}


	if(1) {
		var _changedjson = json_stringify(gSceneStruct);
		FileWrite(WORKFILEPATH + FILEJSON_scene, _changedjson);
	}
	
	DebugMes([gSleepersStruct, gSleepersSpritesStruct, gSceneStruct.sleepers]);
	DebugMes([gBackgroundsStruct, gBackgroundsSpritesStruct, gSceneStruct.backgrounds]);
	DebugMes([gDecoratesStruct, gDecoratesSpritesStruct, gSceneStruct.decorates]);
	DebugMes([gBedsStruct, gBedsSpritesStruct, gSceneStruct.beds]);
}

function SaveCloudPack() {
	static ChildFunc_Save = function(fileJson, _gStruct, _gSpriteStruct, _gSceneStructArr, _obj_SceneElement) {
		for(var i = 0; i < array_length(_gSceneStructArr); i++) {
			if(CheckStructCanBeUse(_gSceneStructArr[i]) == false) {
				continue;
			}
			delete _gSceneStructArr[i];
		}
		array_delete(_gSceneStructArr, 0, array_length(_gSceneStructArr));
		
		
		for(var i = 0; i < instance_count; i++) {
			if(InstanceExists(instance_id[i]))
			if(instance_id[i].object_index == _obj_SceneElement) {
				if(instance_id[i].materialId >= 0 && instance_id[i].materialId < array_length(_gSpriteStruct.sprites)) {
					array_push(_gSceneStructArr
						, new SSceneElement(
							instance_id[i].materialId
							, instance_id[i].basex
							, instance_id[i].basey));
				}
			}
		}
		
		
		var _jsonStr = json_stringify(_gStruct);
		var _jsonSceneFileWriteRes = FileWrite(fileJson, _jsonStr);
		if(_jsonSceneFileWriteRes != 0) {
			show_message(string(fileJson) + "保存失败！" + string(_jsonSceneFileWriteRes));
		}
	}
	
	SceneElementsActivate();
	__InstancesOptimizeFreezing = 2;
	
	// 让保存部分在所有场景元素激活后一帧再执行
	var _timeSourceTemp = time_source_create(time_source_game, 1, time_source_units_frames, function() {
		var ChildFunc_Save = argument[0];
		
		ChildFunc_Save(WORKFILEPATH + FILEJSON_sleepers, gSleepersStruct, gSleepersSpritesStruct, gSceneStruct.sleepers, obj_SceneElementSleeper);
		ChildFunc_Save(WORKFILEPATH + FILEJSON_backgrounds, gBackgroundsStruct, gBackgroundsSpritesStruct, gSceneStruct.backgrounds, obj_SceneElementBackground);
		ChildFunc_Save(WORKFILEPATH + FILEJSON_decorates, gDecoratesStruct, gDecoratesSpritesStruct, gSceneStruct.decorates, obj_SceneElementDecorate);
		ChildFunc_Save(WORKFILEPATH + FILEJSON_beds, gBedsStruct, gBedsSpritesStruct, gSceneStruct.beds, obj_SceneElementBed);
	
	
		var _jsonStr = json_stringify(gSceneStruct);
		var _jsonSceneFileWriteRes = FileWrite(WORKFILEPATH + FILEJSON_scene, _jsonStr);
		if(_jsonSceneFileWriteRes != 0) {
			show_message(WORKFILEPATH + FILEJSON_scene + "保存失败！" + string(_jsonSceneFileWriteRes));
		}
	
	
		GuiElement_CreateMessage("场景包保存完毕");
	}, [ChildFunc_Save]);
	time_source_start(_timeSourceTemp);
}



/*
{
	"guid":"{xxxxxxxxx}",
	"mainclient":"xxxxxxxx",
	"mainclient_howtoget":"xxxxxxxx",
	"compatibleclients":"xxxxxx$$xxxxxx$$xxxx",
	"ipport":"xxx.xxx.xxx.xxx:xxxxx",
	"description":"xxxxxxxx"
}
*/

function ReadCloudPackGuid() {
	var res = "";
	
	var packfname = WORKFILEPATH + PackName + ".cloudpack";
	var fReadRes = FileRead(packfname);
	if(fReadRes == NULL) {
		show_message("读取 " + string(packfname) + " 失败！");
		return NULL;
	}
	
	if(fReadRes == "") {
		show_message(string(packfname) + " 文件为空！");
		return NULL;
	}
	
	var _structTemp = {};
	try {
		_structTemp = json_parse(fReadRes);
	} catch(error) {
		show_message(packfname + "\n这什么鬼文件，看不懂，下一个\n" + "" + string(error.message));
		return NULL;
	}
	
	if(CheckStructCanBeUse(_structTemp)) {
		if(variable_struct_get(_structTemp, "guid") != undefined) {
			res = _structTemp.guid;
		} else {
			show_message("无法从 " + string(packfname) + " 中找到Guid！");
			return NULL;
		}
	}
	
	return res;
}

function RemakeCloudPackGuid(ask = true) {
	if(ask) {
		if(show_question("你确定要这么做吗？") == false) {
			return NULL;
		}
		if(show_question("你真的确定要这么做吗？？") == false) {
			return NULL;
		}
	}
	
	var packfname = WORKFILEPATH + PackName + ".cloudpack";
	var fReadRes = FileRead(packfname);
	if(fReadRes == NULL) {
		show_message("读取 " + string(packfname) + " 失败！");
		return NULL;
	}
	
	var _structTemp = {};
	try {
		_structTemp = json_parse(fReadRes);
	} catch(error) {
		_structTemp = {};
	}
	
	if(CheckStructCanBeUse(_structTemp)) {
		_structTemp.guid = GuidGenerate();
	}
	
	var fWriteRes = FileWrite(packfname, json_stringify(_structTemp));
	if(fWriteRes != 0) {
		show_message("写入文件失败");
		
		return NULL;
	}
	
	return _structTemp.guid;
}

/// @desc 返回 [packfname, _structTemp]
function EditCloudPack_Head() {
	var packfname = WORKFILEPATH + PackName + ".cloudpack";
	var fReadRes = FileRead(packfname);
	if(fReadRes == NULL) {
		show_message("读取 " + string(packfname) + " 失败！");
		return NULL;
	}
	
	var _structTemp = {};
	try {
		_structTemp = json_parse(fReadRes);
	} catch(error) {
		_structTemp = {};
	}
	
	return [packfname, _structTemp];
}

function EditCloudPackArgEasy(_var_name, _get_string_showStr) {
	var temp = EditCloudPack_Head();
	if(temp == NULL) {
		return;
	}
	var packfname = temp[0];
	var _structTemp = temp[1];
	
	
	var strTemp = "";
	if(variable_struct_get(_structTemp, _var_name) != undefined) {
		strTemp = get_string(_get_string_showStr, string(_structTemp[$ _var_name]));
	} else {
		_structTemp[$ _var_name] = "";
		strTemp = get_string(_get_string_showStr, "");
	}
	if(strTemp != "") {
		_structTemp[$ _var_name] = strTemp;
	}
	
	var fWriteRes = FileWrite(packfname, json_stringify(_structTemp));
	if(fWriteRes != 0) {
		show_message("写入文件失败");
	}
}

function EditCloudPackMainClient() {
	EditCloudPackArgEasy("mainclient", "编辑该场景包的主客户端版本号");
}

function EditCloudPackMainClientHowToGet() {
	EditCloudPackArgEasy("mainclient_howtoget", "编辑该场景包的主客户端的获取方式（如需换行请在换行处输入\"\\n\"）");
}

function EditCloudPackCompatibleClients() {
	EditCloudPackArgEasy("compatibleclients", "编辑该场景包的兼容客户端的版本号（不同客户端之间用\"$$\"分割\n例如AVer1.0.0$$BVer1.2.1$$CVer1.5.6）");
}

function EditCloudPackIpPort() {
	EditCloudPackArgEasy("ipport", "编辑该场景包的默认服务器地址（IP和端口间用\":\"分割\n例如：127.0.0.1:14514）");
}

function EditCloudPackDescription() {
	EditCloudPackArgEasy("description", "编辑该场景包的简介（如需换行请在换行处输入\"\\n\"）");
}


function EditTextboxPlaceHolders() {
	if(file_exists(WORKFILEPATH + FILEJSON_TextboxPlaceHolders) == false) {
		FileWrite(WORKFILEPATH + FILEJSON_TextboxPlaceHolders,
			"[" + "\n" + 
				"\"在此处输入文字\"," + "\n" + 
				"\"用户名：$NAME\"," + "\n" + 
				"\"占位文本可以有多行\"" + "\n" + 
			"]"
		);
	}
	OpenInExplorer(WORKFILEPATH + FILEJSON_TextboxPlaceHolders);
}


function OpenInExplorer(fname) {
	systemCmd("start \"\" \"" + fname + "\"");
}


//globalvar gArrSceneDefaultBackgroundsSurf;
//gArrSceneDefaultBackgroundsSurf = undefined;

/// @desc 设置场景包的默认背景
function SetSceneDefaultBackground(_materialId) {
	gSceneStruct.defaultBackground = _materialId;
	
	//var _ylen = array_length(gArrSceneDefaultBackgroundsSurf);
	//for(var iy = 0; iy < _ylen; iy++) {
	//	var _xlen = array_length(gArrSceneDefaultBackgroundsSurf[iy]);
	//	for(var ix = 0; ix < _xlen; ix++) {
	//		surface_free(gArrSceneDefaultBackgroundsSurf[iy][ix]);
	//	}
	//}
	
	//gArrSceneDefaultBackgroundsSurf = undefined;
	//CheckAndRemakeSceneDefaultBackgroundsSurf();
}

//function CheckAndRemakeSceneDefaultBackgroundsSurf() {
//	static _singleSurfSize = 16384;
	
//	var _defaultBackgroundMaterialId = gSceneStruct.defaultBackground;
//	if(_defaultBackgroundMaterialId < 0 || _defaultBackgroundMaterialId >= array_length(gBackgroundsStruct.materials)) {
//		return;
//	}
	
//	if(gArrSceneDefaultBackgroundsSurf != undefined) {
//		if(surface_exists(gArrSceneDefaultBackgroundsSurf[0][0])) {
//			return;
//		}
//	}
	
//	var _spr = gBackgroundsSpritesStruct.sprites[_defaultBackgroundMaterialId];
//	if(!sprite_exists(_spr)) {
//		return;
//	}
//	var _sprW = sprite_get_width(_spr);
//	var _sprH = sprite_get_height(_spr);
	
//	var _xoff = 0, _yoff = 0;
	
//	SaveDrawSettings();
	
//	draw_set_color(c_white);
//	draw_set_alpha(1);
	
//	var _ylen = ceil((gSceneStruct.bottom - gSceneStruct.top) * SCENE_CellSize / _singleSurfSize);
//	for(var iy = 0; iy < _ylen; iy++) {
//		var _xlen = ceil((gSceneStruct.right - gSceneStruct.left) * SCENE_CellSize / _singleSurfSize);
//		for(var ix = 0; ix < _xlen; ix++) {
//			var _surfTemp = surface_create(_singleSurfSize, _singleSurfSize);
			
//			surface_set_target(_surfTemp);
			
//			var _jxlen = ceil(_singleSurfSize / _sprW);
//			var _jylen = ceil(_singleSurfSize / _sprH);
//			for(var jy = 0; jy < _jylen; jy++) {
//				for(var jx = 0; jx < _jxlen; jx++) {
//					draw_sprite(_spr, 0, _xoff + jx * _sprW, _yoff + jy * _sprH);
//				}
//			}
			
//			_xoff = _singleSurfSize - (_jxlen * _sprW + _xoff) - _sprW;
//			_yoff = _singleSurfSize - (_jylen * _sprH + _yoff) - _sprH;
			
//			surface_reset_target();
			
//			gArrSceneDefaultBackgroundsSurf[iy][ix] = _surfTemp;
//		}
//	}
	
//	LoadDrawSettings();
//}
