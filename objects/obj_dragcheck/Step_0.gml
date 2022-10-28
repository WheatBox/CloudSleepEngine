if(
	IsMouseOnGUI == false
	&& !InstanceExists(gSandboxSceneElementsDragging)
	&& gSandboxGuiElementsDragObjIsOnRightClick == false
	&& gSandboxMode == ESandboxMode.Normal
) {
	var checkSceneElementObj = noone;
	switch(gSandboxSceneElementsLayer) {
		case ESandboxSceneElementsLayers.sleepers:
			checkSceneElementObj = obj_SceneElementSleeper;
			break;
		case ESandboxSceneElementsLayers.backgrounds:
			checkSceneElementObj = obj_SceneElementBackground;
			break;
		case ESandboxSceneElementsLayers.decorates:
			checkSceneElementObj = obj_SceneElementDecorate;
			break;
		case ESandboxSceneElementsLayers.beds:
			checkSceneElementObj = obj_SceneElementBed;
			break;
	}
	
	if(checkSceneElementObj != noone) {
		var collisionList = ds_list_create();
		
		collision_point_list(mouse_x, mouse_y, checkSceneElementObj, true, false, collisionList, false);
		
		insMouseOn = collisionList[| ds_list_size(collisionList) - 1];
		if(MouseLeftPressed()) {
			gSandboxSceneElementsDragging = insMouseOn;
		}
		
		ds_list_destroy(collisionList);
	}
}