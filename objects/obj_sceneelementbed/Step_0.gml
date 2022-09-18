event_inherited();

SynchDepth(basey);

switch(gSandboxSceneElementsLayer) {
	case ESandboxSceneElementsLayers.nothing:
	case ESandboxSceneElementsLayers.beds:
		image_alpha = 1.0;
		break;
	default:
		image_alpha = 0.2;
}

if(inited == false) {
	inited = true;
}

if(array_length(gBedsStruct.materials[materialId].offset) >= 2) {
	offsetx = gBedsStruct.materials[materialId].offset[0];
	offsety = gBedsStruct.materials[materialId].offset[1];
}
