if(GUI_MouseGuiOnMe(x - width / 2, y - height / 2, x + width / 2, y + height / 2)) {
	mouseOnMe = true;
	gMouseOnGUI = true;
} else {
	mouseOnMe = false;
}

if(MouseLeftPressed() && mouseOnMe && !InstanceExists(gSandboxSceneElementsDragging) && gSandboxGuiElementsDragObjIsOnRightClick == false) {
	switch(gSandboxMode) {
		case ESandboxMode.Normal:
			isDragging = true;
	
			switch(mySandboxSceneElementsLayer) {
				case ESandboxSceneElementsLayers.sleepers:
					mySceneElementIns = SceneElement_CreateSleeper(materialId, , , , sprite_index);
					break;
				case ESandboxSceneElementsLayers.backgrounds:
					mySceneElementIns = SceneElement_CreateBackground(materialId, , , , sprite_index);
					break;
				case ESandboxSceneElementsLayers.decorates:
					mySceneElementIns = SceneElement_CreateDecorate(materialId, , , , sprite_index);
					break;
				case ESandboxSceneElementsLayers.beds:
					mySceneElementIns = SceneElement_CreateBed(materialId, , , , sprite_index);
					break;
			}
	
			gSandboxSceneElementsDragging = mySceneElementIns;
			
			break;
		case ESandboxMode.Pencil:
			gSandboxPencilMaterialId = materialId;
			gSandboxPencilSceneElementsLayer = mySandboxSceneElementsLayer;
			break;
	}
}

if(gSandboxSceneElementsDragging != noone && isDragging) {
	if(MouseLeftHold()) {
		
	} else {
		isDragging = false;
		gSandboxSceneElementsDragging = noone;
	}
}

// DebugMes([gSandboxSceneElementsLayer, gSandboxSceneElementsDragging, InstanceExists(gSandboxSceneElementsDragging), gSandboxGuiElementsDragObjIsOnRightClick]);