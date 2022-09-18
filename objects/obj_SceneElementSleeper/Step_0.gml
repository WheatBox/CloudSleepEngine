event_inherited();

SynchDepth(basey);

switch(gSandboxSceneElementsLayer) {
	case ESandboxSceneElementsLayers.nothing:
	case ESandboxSceneElementsLayers.sleepers:
		image_alpha = 1.0;
		break;
	default:
		image_alpha = 0.2;
}

if(inited == false) {
	inited = true;
}

if(array_length(gSleepersStruct.materials[materialId].offset) >= 2) {
	offsetx = gSleepersStruct.materials[materialId].offset[0];
	offsety = gSleepersStruct.materials[materialId].offset[1];
}
