var _sceneStructBackgroundsLen = array_length(gSceneStruct.backgrounds);
for(var i = 0; i < _sceneStructBackgroundsLen; i++) {
	if(CheckStructCanBeUse(gSceneStruct.backgrounds[i])) {
		if(gSceneStruct.backgrounds[i].materialId >= 0 && gSceneStruct.backgrounds[i].materialId < array_length(gBackgroundsSpritesStruct.sprites)) {
			var _newIns = SceneElement_CreateBackground(gSceneStruct.backgrounds[i].materialId, false, gSceneStruct.backgrounds[i].xPos, gSceneStruct.backgrounds[i].yPos);
			_newIns.inited = true;
			_newIns.mygSceneStructI = i;
		}
	}
}
var _sceneStructDecoratesLen = array_length(gSceneStruct.decorates);
for(var i = 0; i < _sceneStructDecoratesLen; i++) {
	if(CheckStructCanBeUse(gSceneStruct.decorates[i])) {
		if(gSceneStruct.decorates[i].materialId >= 0 && gSceneStruct.decorates[i].materialId < array_length(gDecoratesSpritesStruct.sprites)) {
			var _newIns = SceneElement_CreateDecorate(gSceneStruct.decorates[i].materialId, false, gSceneStruct.decorates[i].xPos, gSceneStruct.decorates[i].yPos);
			_newIns.inited = true;
			_newIns.mygSceneStructI = i;
		}
	}
}
var _sceneStructBedsLen = array_length(gSceneStruct.beds);
for(var i = 0; i < _sceneStructBedsLen; i++) {
	if(CheckStructCanBeUse(gSceneStruct.beds[i])) {
		if(gSceneStruct.beds[i].materialId >= 0 && gSceneStruct.beds[i].materialId < array_length(gBedsSpritesStruct.sprites)) {
			var _newIns = SceneElement_CreateBed(gSceneStruct.beds[i].materialId, false, gSceneStruct.beds[i].xPos, gSceneStruct.beds[i].yPos);
			_newIns.inited = true;
			_newIns.mygSceneStructI = i;
		}
	}
}
