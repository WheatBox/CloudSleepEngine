var MyChildFunc_CreateSceneElements = function(_gSpriteStruct, _gSceneStructArr, _func_SceneElement_Create) {
	var _sceneStructLen = array_length(_gSceneStructArr);
	for(var i = 0; i < _sceneStructLen; i++) {
		if(CheckStructCanBeUse(_gSceneStructArr[i])) {
			if(_gSceneStructArr[i].materialId >= 0 && _gSceneStructArr[i].materialId < array_length(_gSpriteStruct.sprites)) {
				var _newIns = _func_SceneElement_Create(_gSceneStructArr[i].materialId, false, _gSceneStructArr[i].xPos, _gSceneStructArr[i].yPos);
				_newIns.inited = true;
				_newIns.mygSceneStructI = i;
			}
		}
	}
}

MyChildFunc_CreateSceneElements(gSleepersSpritesStruct, gSceneStruct.sleepers, SceneElement_CreateSleeper);
MyChildFunc_CreateSceneElements(gBackgroundsSpritesStruct, gSceneStruct.backgrounds, SceneElement_CreateBackground);
MyChildFunc_CreateSceneElements(gDecoratesSpritesStruct, gSceneStruct.decorates, SceneElement_CreateDecorate);
MyChildFunc_CreateSceneElements(gBedsSpritesStruct, gSceneStruct.beds, SceneElement_CreateBed);

