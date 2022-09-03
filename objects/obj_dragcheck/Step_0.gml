if(MouseLeftPressed() && gMouseOnGUI == false && !InstanceExists(gSandboxSceneElementsDragging) && gSandboxGuiElementsDragObjIsOnRightClick == false) {
	var checkSceneElementObj = noone;
	switch(gSandboxSceneElementsLayer) {
		case ESandboxSceneElementsLayers.backgrounds:
			checkSceneElementObj = obj_SceneElementBackground;
			break;
	}
	
	if(checkSceneElementObj != noone) {
		var collisionList = ds_list_create();
		
		collision_point_list(mouse_x, mouse_y, checkSceneElementObj, true, false, collisionList, false);
		
		gSandboxSceneElementsDragging = collisionList[| ds_list_size(collisionList) - 1];
		
		ds_list_destroy(collisionList);
	}
}