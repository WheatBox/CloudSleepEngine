#macro SceneDepth -100

globalvar gSceneElementsGridAlignmentEnable;
gSceneElementsGridAlignmentEnable = true;

function SceneElement_CreateBackground(_materialId, _isDragging = true, _x = mouse_x, _y = mouse_y, sprite = -1) {
	var ins = instance_create_depth(_x, _y, SceneDepth + 1, obj_SceneElementBackground);
	
	if(sprite == -1) {
		if(_materialId >= 0 && _materialId < array_length(gBackgroundsSpritesStruct.sprites)) {
			sprite = gBackgroundsSpritesStruct.sprites[_materialId];
		}
	}
	ins.sprite_index = sprite;
	ins.isDragging = _isDragging;
	
	ins.materialId = _materialId;
	
	// 为何上面写 SceneDepth + 1 然后这里又 depth--;
	// 因为我也不知道为啥，反正不这么写而直接填 SceneDepth 就会导致晚创建的物体在早创建的物体的下面
	ins.depth--;
	
	DebugMes(["new bg:", ins, _x, ins.depth]);
	
	return ins;
}

function SceneElement_ClearBackgroundIns(_materialId, counts = 1) {
	with(obj_SceneElementBackground) {
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