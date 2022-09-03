#macro FILEPATH_backgrounds "\\contents\\backgrounds\\"
#macro FILEPATH_decorates "\\contents\\decorates\\"
#macro FILEPATH_beds "\\contents\\beds\\"

#macro FILEJSON_backgrounds "\\contents\\backgrounds.json"
#macro FILEJSON_decorates "\\contents\\decorates.json"
#macro FILEJSON_beds "\\contents\\beds.json"

// #macro WORKFILEPATH ".\\packages\\" + PackName + "\\"
#macro WORKFILEPATH "F:\\CSETemp\\packages\\" + PackName + "\\"

#macro PackFileExtension ".cloudpack"

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
	var fbackgrounds = NULL;
	
	if(FileGetSize(WORKFILEPATH + FILEJSON_backgrounds) > 0) {
		fbackgrounds = FileRead(WORKFILEPATH + FILEJSON_backgrounds);
	}
	
	if(fbackgrounds != NULL) {
		gBackgroundsStruct = json_parse(fbackgrounds);
		
		var _changed = false;
		for(var i = 0; i < array_length(gBackgroundsStruct.filename); i++) {
			var _name = gBackgroundsStruct.filename[i];
			
			if(FileGetSize(WORKFILEPATH + FILEPATH_backgrounds + _name) <= 0) {
				// 删除失效文件名
				array_delete(gBackgroundsStruct.filename, i, 1);
				_changed = true;
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
}

