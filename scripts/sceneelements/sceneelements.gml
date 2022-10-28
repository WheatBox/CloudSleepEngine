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

function SandboxPencilWork() {
	static _working = false;
	static _firstX = 0, _firstY = 0;
	static _sprite = -1;
	static _width = 0, _height = 0;
	static _xoff = 0, _yoff = 0;
	static _mapCreatingPos = ds_map_create(); // 格式：[? "x,y"]
	static _creatingXPrev = undefined, _creatingYPrev = undefined;
	static _createFunc = undefined;
	
	if(gSandboxMode != ESandboxMode.Pencil) {
		return;
	}
	
	if(MouseLeftPressed()) {
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
				break;
			case ESandboxSceneElementsLayers.backgrounds:
				_structToCheckTemp = gBackgroundsStruct;
				_structSpriteTemp = gBackgroundsSpritesStruct;
				_createFunc = SceneElement_CreateBackground;
				break;
			case ESandboxSceneElementsLayers.decorates:
				_structToCheckTemp = gDecoratesStruct;
				_structSpriteTemp = gDecoratesSpritesStruct;
				_createFunc = SceneElement_CreateDecorate;
				break;
			case ESandboxSceneElementsLayers.beds:
				_structToCheckTemp = gBedsStruct;
				_structSpriteTemp = gBedsSpritesStruct;
				_createFunc = SceneElement_CreateBed;
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
			DebugMes(["off", _xoff, _yoff]);
		}
		ds_map_clear(_mapCreatingPos);
		_creatingXPrev = undefined;
		_creatingYPrev = undefined;
		
		_working = true;
	}
	
	var _cxtemp = 0, _cytemp = 0;
	
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
	
	if(!_working) {
		return;
	}
	
	if(MouseLeftHold() == false) {
		_working = false;
	} else if(IsMouseOnGUI == false) {
		var _mapCreatingPosStrTemp = string(_cxtemp) + "," + string(_cytemp);
		if(_mapCreatingPos[? _mapCreatingPosStrTemp] == undefined) {
			_mapCreatingPos[? _mapCreatingPosStrTemp] = 1;
			_createFunc(gSandboxPencilMaterialId, false, _cxtemp, _cytemp, _sprite);
		}
	}
}
