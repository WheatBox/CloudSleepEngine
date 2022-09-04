var _sceneStructBackgroundsLen = array_length(gSceneStruct.backgrounds);
for(var i = 0; i < _sceneStructBackgroundsLen; i++) {
	if(CheckStructCanBeUse(gSceneStruct.backgrounds[i])) {
		if(gSceneStruct.backgrounds[i].materialId >= 0 && gSceneStruct.backgrounds[i].materialId < array_length(gBackgroundsSpritesStruct.sprites)) {
			var _newBgIns = SceneElement_CreateBackground(gSceneStruct.backgrounds[i].materialId, false, gSceneStruct.backgrounds[i].xPos, gSceneStruct.backgrounds[i].yPos);
			_newBgIns.inited = true;
			_newBgIns.mygSceneStructI = i;
		}
	}
}
