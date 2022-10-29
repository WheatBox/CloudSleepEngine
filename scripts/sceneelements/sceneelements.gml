#macro SceneDepthBackgrounds 1000
#macro SceneDepthDynamicAdd -1000

globalvar gSceneElementsGridAlignmentEnable, gGridShowHitBoxEnable;
gSceneElementsGridAlignmentEnable = true;
gGridShowHitBoxEnable = false;

globalvar gOutFocusLayerAlpha, gGridAlpha;
gOutFocusLayerAlpha = 0.3;
gGridAlpha = 0.2;

function SceneElement_CreateSleeper(_materialId, _isDragging = true, _x = mouse_x, _y = mouse_y, sprite = -1) {
	return SceneElement_Create(obj_SceneElementSleeper, SceneDepthDynamicAdd, gSleepersSpritesStruct, _materialId, _isDragging, _x, _y, sprite);
}

function SceneElement_CreateBackground(_materialId, _isDragging = true, _x = mouse_x, _y = mouse_y, sprite = -1) {
	return SceneElement_Create(obj_SceneElementBackground, SceneDepthBackgrounds + 1, gBackgroundsSpritesStruct, _materialId, _isDragging, _x, _y, sprite);
}

function SceneElement_CreateDecorate(_materialId, _isDragging = true, _x = mouse_x, _y = mouse_y, sprite = -1) {
	return SceneElement_Create(obj_SceneElementDecorate, SceneDepthDynamicAdd, gDecoratesSpritesStruct, _materialId, _isDragging, _x, _y, sprite);
}

function SceneElement_CreateBed(_materialId, _isDragging = true, _x = mouse_x, _y = mouse_y, sprite = -1) {
	return SceneElement_Create(obj_SceneElementBed, SceneDepthDynamicAdd, gBedsSpritesStruct, _materialId, _isDragging, _x, _y, sprite);
}

function SceneElement_Create(_obj, _depth, __gSpriteStruct, _materialId, _isDragging = true, _x = mouse_x, _y = mouse_y, sprite = -1) {
	var ins = instance_create_depth(_x, _y, _depth, _obj);
	
	if(sprite == -1) {
		if(_materialId >= 0 && _materialId < array_length(__gSpriteStruct.sprites)) {
			sprite = __gSpriteStruct.sprites[_materialId];
		}
	}
	ins.sprite_index = sprite;
	ins.isDragging = _isDragging;
	
	ins.materialId = _materialId;
	
	return ins;
}


function SceneElement_ClearSleeperIns(_materialId, counts = 1) {
	SceneElement_ClearIns(obj_SceneElementSleeper, _materialId, counts);
}

function SceneElement_ClearBackgroundIns(_materialId, counts = 1) {
	SceneElement_ClearIns(obj_SceneElementBackground, _materialId, counts);
}

function SceneElement_ClearDecorateIns(_materialId, counts = 1) {
	SceneElement_ClearIns(obj_SceneElementDecorate, _materialId, counts);
}

function SceneElement_ClearBedIns(_materialId, counts = 1) {
	SceneElement_ClearIns(obj_SceneElementBed, _materialId, counts);
}

function SceneElement_ClearIns(_obj, _materialId, counts = 1) {
	with(_obj) {
		if(materialId >= _materialId && materialId < _materialId + counts) {
			instance_destroy(id);
		} else if(materialId >= _materialId + counts) {
			materialId -= counts;
		}
	}
}


/*
/// @desc 删除 GuiElement 后整理目前已放置的 obj_SceneElementBackgrounds
function SceneElement_BackgroundsAlignAfterDelete(deletedBeginI, deletedNum) {
	var _sceneStructBackgroundsLen = array_length(gSceneStruct.backgrounds);
	for(var i = 0; i < _sceneStructBackgroundsLen; i++) {
		if(gSceneStruct.backgrounds[i].materialId > deletedBeginI) {
			gSceneStruct.backgrounds[i].materialId -= deletedNum;
		}
	}
	with(obj_SceneElementBackground) {
		if(materialId > deletedBeginI) {
			materialId -= deletedNum;
		}
	}
}
*/


enum ESandboxMode {
	Normal,
	Pencil,
	Eraser,
};

globalvar gSandboxMode;

gSandboxMode = ESandboxMode.Normal;

globalvar gSandboxPencilSceneElementsLayer, gSandboxPencilMaterialId;
gSandboxPencilSceneElementsLayer = ESandboxSceneElementsLayers.backgrounds;
gSandboxPencilMaterialId = 0;

/// @desc 鼠标左键：放置当前指定的场景素材，鼠标右键：仅擦除与当前指定场景素材一样的场景素材
function SandboxPencilWork() {
	static _working = false;
	static _firstX = 0, _firstY = 0;
	static _sprite = -1;
	static _width = 0, _height = 0;
	static _xoff = 0, _yoff = 0;
	static _mapCreatingPos = ds_map_create(); // 格式：[? "x,y"]
	static _creatingXPrev = undefined, _creatingYPrev = undefined;
	static _createFunc = undefined;
	
	static _eraserObj = noone;
	
	if(gSandboxMode != ESandboxMode.Pencil) {
		return;
	}
	
	if(MouseLeftPressed() || MouseRightPressed()) {
		_working = false;
		
		if(gSandboxPencilMaterialId < 0)
			return;
	
		var _structToCheckTemp = undefined;
		var _structSpriteTemp = undefined;
		switch(gSandboxPencilSceneElementsLayer) {
			case ESandboxSceneElementsLayers.nothing:
				return;
			case ESandboxSceneElementsLayers.sleepers:
				_structToCheckTemp = gSleepersStruct;
				_structSpriteTemp = gSleepersSpritesStruct;
				_createFunc = SceneElement_CreateSleeper;
				_eraserObj = obj_SceneElementSleeper;
				break;
			case ESandboxSceneElementsLayers.backgrounds:
				_structToCheckTemp = gBackgroundsStruct;
				_structSpriteTemp = gBackgroundsSpritesStruct;
				_createFunc = SceneElement_CreateBackground;
				_eraserObj = obj_SceneElementBackground;
				break;
			case ESandboxSceneElementsLayers.decorates:
				_structToCheckTemp = gDecoratesStruct;
				_structSpriteTemp = gDecoratesSpritesStruct;
				_createFunc = SceneElement_CreateDecorate;
				_eraserObj = obj_SceneElementDecorate;
				break;
			case ESandboxSceneElementsLayers.beds:
				_structToCheckTemp = gBedsStruct;
				_structSpriteTemp = gBedsSpritesStruct;
				_createFunc = SceneElement_CreateBed;
				_eraserObj = obj_SceneElementBed;
				break;
			default:
				return;
		}
		if(_structToCheckTemp == undefined || _structSpriteTemp == undefined || _createFunc == undefined) {
			return;
		}
		if(CheckStructCanBeUse(_structToCheckTemp) == false || CheckStructCanBeUse(_structSpriteTemp) == false) {
			return;
		}
	
		var _arrToCheckTemp = _structToCheckTemp[$ "materials"];
		var _arrSpriteTemp = _structSpriteTemp[$ "sprites"];
		if(_arrToCheckTemp == undefined || _arrSpriteTemp == undefined) {
			return;
		}
	
		if(gSandboxPencilMaterialId >= array_length(_arrToCheckTemp) || gSandboxPencilMaterialId >= array_length(_arrSpriteTemp)) {
			return;
		}
		
		if(_arrSpriteTemp[gSandboxPencilMaterialId] < 0 || !sprite_exists(_arrSpriteTemp[gSandboxPencilMaterialId])) {
			return;
		}
		
		
		_sprite = _arrSpriteTemp[gSandboxPencilMaterialId];
		_width = sprite_get_width(_sprite);
		_height = sprite_get_height(_sprite);
		_xoff = sprite_get_xoffset(_sprite);
		_yoff = sprite_get_yoffset(_sprite);
		if(_arrToCheckTemp[gSandboxPencilMaterialId][$ "offset"] != undefined)
		if(is_array(_arrToCheckTemp[gSandboxPencilMaterialId].offset))
		if(array_length(_arrToCheckTemp[gSandboxPencilMaterialId].offset) >= 2) {
			_xoff = _arrToCheckTemp[gSandboxPencilMaterialId].offset[0];
			_yoff = _arrToCheckTemp[gSandboxPencilMaterialId].offset[1];
		}
		ds_map_clear(_mapCreatingPos);
		_creatingXPrev = undefined;
		_creatingYPrev = undefined;
		
		_working = true;
	}
	
	var _mouseLeftHold = MouseLeftHold();
	var _mouseRightHold = MouseRightHold();
	
	var _cxtemp = 0, _cytemp = 0;
	
	if(_mouseRightHold == false) {
		if(sprite_exists(_sprite)) {
			if(!_working) {
				if(gSceneElementsGridAlignmentEnable) {
					_firstX = GetPositionXGridStandardization(mouse_x);
					_firstY = GetPositionYGridStandardization(mouse_y);
				} else {
					_firstX = mouse_x;
					_firstY = mouse_y;
				}
			}
		
			if(gSceneElementsGridAlignmentEnable) {
				_cxtemp = GetPositionXGridStandardization(mouse_x);
				_cytemp = GetPositionYGridStandardization(mouse_y);
			} else {
				_cxtemp = mouse_x;
				_cytemp = mouse_y;
			}
		
			_cxtemp = round((_cxtemp - _firstX) / _width) * _width + _firstX;
			_cytemp = round((_cytemp - _firstY) / _height) * _height + _firstY;
		
			draw_set_color(c_white);
			draw_set_alpha(1.0);
			draw_sprite(_sprite, 0, _cxtemp + _width / 2 - _xoff, _cytemp + _height / 2 - _yoff);
		} else {
			_working = false;
			return;
		}
	}
	
	if(!_working) {
		return;
	}
	
	if(_mouseLeftHold == false && _mouseRightHold == false) {
		_working = false;
	} else if(IsMouseOnGUI == false) {
		if(_mouseLeftHold) {
			var _mapCreatingPosStrTemp = string(_cxtemp) + "," + string(_cytemp);
			if(_mapCreatingPos[? _mapCreatingPosStrTemp] == undefined) {
				_mapCreatingPos[? _mapCreatingPosStrTemp] = 1;
				_createFunc(gSandboxPencilMaterialId, false, _cxtemp, _cytemp, _sprite);
			}
		} else if(_mouseRightHold) {
			var _eraserListTemp = ds_list_create();
			var _eraserListTempLen = instance_position_list(mouse_x, mouse_y, _eraserObj, _eraserListTemp, false);
			for(var i = 0; i < _eraserListTempLen; i++) {
				if(_eraserListTemp[| i][$ "materialId"] == gSandboxPencilMaterialId) {
					instance_destroy(_eraserListTemp[| i]);
				}
			}
			ds_list_destroy(_eraserListTemp);
		}
	}
}

/// @desc
function SandboxEraserWork() {
	if(gSandboxMode != ESandboxMode.Eraser) {
		return;
	}
	
	if(IsMouseOnGUI) {
		return;
	}
	
	if(gSandboxSceneElementsLayer == ESandboxSceneElementsLayers.nothing) {
		var _arrEraserObj = [
			obj_SceneElementSleeper,
			obj_SceneElementBackground,
			obj_SceneElementDecorate,
			obj_SceneElementBed
		];
		var _eraserListTemp = ds_list_create();
		for(var j = 0; j < array_length(_arrEraserObj); j++) {
			var _eraserListTempLen = instance_position_list(mouse_x, mouse_y, _arrEraserObj[j], _eraserListTemp, false);
			for(var i = 0; i < _eraserListTempLen; i++) {
				if(MouseLeftHold()) {
					instance_destroy(_eraserListTemp[| i]);
				} else {
					_eraserListTemp[| i].MySetColorRed();
				}
			}
			ds_list_clear(_eraserListTemp)
		}
		ds_list_destroy(_eraserListTemp);
	} else {
		var _eraserObj = noone;
		switch(gSandboxSceneElementsLayer) {
			case ESandboxSceneElementsLayers.sleepers:
				_eraserObj = obj_SceneElementSleeper;
				break;
			case ESandboxSceneElementsLayers.backgrounds:
				_eraserObj = obj_SceneElementBackground;
				break;
			case ESandboxSceneElementsLayers.decorates:
				_eraserObj = obj_SceneElementDecorate;
				break;
			case ESandboxSceneElementsLayers.beds:
				_eraserObj = obj_SceneElementBed;
				break;
			default:
				return;
		}
		var _eraserListTemp = ds_list_create();
		var _eraserListTempLen = instance_position_list(mouse_x, mouse_y, _eraserObj, _eraserListTemp, false);
		for(var i = 0; i < _eraserListTempLen; i++) {
			if(MouseLeftHold()) {
				instance_destroy(_eraserListTemp[| i]);
			} else {
				_eraserListTemp[| i].MySetColorRed();
			}
		}
		ds_list_destroy(_eraserListTemp);
	}
}
