event_inherited();

switch(gSandboxSceneElementsLayer) {
	case ESandboxSceneElementsLayers.nothing:
	case ESandboxSceneElementsLayers.backgrounds:
		image_alpha = 1.0;
		break;
	default:
		image_alpha = 0.2;
}
