function GuiElement_CreateImportBackgroundButton(_xGui, _yGui, _label, _width = undefined, _height = undefined) {
	var ins = GuiElement_CreateButton_ext(_xGui, _yGui, _label, _width, _height,
		function() { 
			var filename = FileNameGetPicture("背景");
			if(filename != "") {
				var _name = GetNameFromFileName(filename, true);
				FileCopy(filename, WORKFILEPATH + FILEPATH_backgrounds + _name);
				DebugMes([filename, " copy to ", WORKFILEPATH + FILEPATH_backgrounds + _name]);
				
				var _jsonName = WORKFILEPATH + FILEJSON_backgrounds;
				if(FileGetSize(_jsonName) > 0) {
					var _jsonStr = FileRead(_jsonName);
					gBackgroundsStruct = json_parse(_jsonStr);
				} else {
					gBackgroundsStruct = DefaultStruct;
				}
				
				
				var _conflicted = false;
				// 检查是否重复了
				for(var i = 0; i < array_length(gBackgroundsStruct.filename); i++) {
					if(gBackgroundsStruct.filename[i] == _name) {
						_conflicted = true;
						show_message("导入的图片与已有的图片名称冲突！");
						break;
					}
				}
				
				if(_conflicted == false) {
					array_push(gBackgroundsStruct.filename, _name);
					var _jsonDest = json_stringify(gBackgroundsStruct);
					FileWrite(_jsonName, _jsonDest);
				
					// 将图片转换为 spr 并刷新（添加 DragObj）
					if(object_index == obj_sandboxSceneElementsPages) {
						var _sprTemp = sprite_add(WORKFILEPATH + FILEPATH_backgrounds + _name, 1, false, true, 0, 0);
						sprite_set_offset(_sprTemp, sprite_get_width(_sprTemp) / 2, sprite_get_height(_sprTemp) / 2);
						sprite_set_bbox_mode(_sprTemp, bboxmode_automatic);
						array_push(gBackgroundsSpritesStruct.sprites, _sprTemp);
					
						MyRefreshPage();
					}
				}
			}
		}
	);
	
	return ins;
}

/// @arg _xGui x
/// @arg _yGui y
/// @arg _label _labelText
/// @arg _pressedFunc 按下后触发的函数
/// @arg _disposable 是否为一次性的（鼠标左键或右键单击后会删除实例（不管有没有点到按钮本身））
function GuiElement_CreateButton(_xGui, _yGui, _label, _pressedFunc, _disposable = false, _color = GUIDefaultColor) {
	return GuiElement_CreateButton_ext(_xGui, _yGui, _label, , , _pressedFunc, _disposable, _color);
}

/// @arg _xGui x
/// @arg _yGui y
/// @arg _label _labelText
/// @arg _width 宽
/// @arg _height 高
/// @arg _pressedFunc 按下后触发的函数
/// @arg _disposable 是否为一次性的（鼠标左键或右键单击后会删除实例（不管有没有点到按钮本身））
function GuiElement_CreateButton_ext(_xGui, _yGui, _label, _width = undefined, _height = undefined, _pressedFunc, _disposable = false, _color = GUIDefaultColor) {
	var ins = instance_create_depth(_xGui, _yGui,
		GUIDepth, obj_GuiElement_Button);
	ins.labelText = _label;
	ins.width = _width;
	ins.height = _height;
	ins.MyPressedFunction = _pressedFunc;
	ins.Disposable = _disposable;
	ins.color = _color;
	
	if(_width == undefined) {
		ins.width = GUI_GetStringWidth(_label) + 8;
	}
	if(_height == undefined) {
		ins.height = GUI_GetStringHeight(_label) + 2;
	}
	
	return ins;
}

function GuiElement_CreatePage(_xGui, _yGui, _label, _width = undefined, _height = undefined) {
	var ins = instance_create_depth(_xGui, _yGui,
		GUIPageDepth, obj_GuiElement_Page);
	ins.labelText = _label;
	if(_width != undefined) {
		ins.width = _width;
	}
	if(_height != undefined) {
		ins.height = _height
	} else {
		ins.height = display_get_gui_height() - _yGui;
	}
	
	return ins;
}

function GuiElement_CreateDragObj(_xGui, _yGui, _sprite, _filename, _ESandboxSceneElementsLayer, _masterPage, _MaxWorH = 224) {
	var ins = noone;
	
	switch(_ESandboxSceneElementsLayer) {
		case ESandboxSceneElementsLayers.backgrounds:
			ins = instance_create_depth(_xGui, _yGui,
				GUIDragObjDepth, obj_GuiElement_DragObj);
			break;
	}
	
	ins.sprite_index = _sprite;
	
	if(ins.sprite_width > ins.sprite_height) {
		SetSizeLockAspect_Width(_MaxWorH, ins);
	} else {
		SetSizeLockAspect_Height(_MaxWorH, ins);
	}
	
	ins.width = ins.sprite_width;
	ins.height = ins.sprite_height;
	
	ins.myFilename = _filename;
	ins.masterPage = _masterPage;
	ins.mySandboxSceneElementsLayer = _ESandboxSceneElementsLayer;
	
	return ins;
}

