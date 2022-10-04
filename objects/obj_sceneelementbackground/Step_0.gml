event_inherited();

switch(gSandboxSceneElementsLayer) {
	case ESandboxSceneElementsLayers.nothing:
	case ESandboxSceneElementsLayers.backgrounds:
		image_alpha = 1.0;
		break;
	default:
		image_alpha = gOutFocusLayerAlpha;
}

if(inited == false) {
	inited = true;
	/*
	array_push(gSceneStruct.backgrounds, new SSceneElement(materialId, x, y));
	mygSceneStructI = array_length(gSceneStruct.backgrounds) - 1;
	*/
}
/*
if(mygSceneStructI >= 0 && mygSceneStructI < array_length(gSceneStruct.backgrounds)) {
	gSceneStruct.backgrounds[mygSceneStructI].xPos = x;
	gSceneStruct.backgrounds[mygSceneStructI].yPos = y;
}*/
