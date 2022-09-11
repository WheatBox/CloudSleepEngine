#macro SceneDepthBackgrounds 1000
#macro SceneDepthDynamicAdd -1000

globalvar gSceneElementsGridAlignmentEnable;
gSceneElementsGridAlignmentEnable = true;

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
	
	// 为何上面写 SceneDepth + 1 然后这里又 depth--;
	// 因为我也不知道为啥，反正不这么写而直接填 SceneDepth 就会导致晚创建的物体在早创建的物体的下面
	ins.depth--;
	
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