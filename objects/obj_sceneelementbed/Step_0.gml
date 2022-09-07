event_inherited();

AsyncDepth();

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

