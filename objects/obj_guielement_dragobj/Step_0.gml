if(GUI_MouseGuiOnMe(x - width / 2, y - height / 2, x + width / 2, y + height / 2)) {
	mouseOnMe = true;
} else {
	mouseOnMe = false;
}

if(MouseLeftPressed() && mouseOnMe && !InstanceExists(gSandboxSceneElementsDragging) && gSandboxGuiElementsDragObjIsOnRightClick == false) {
	isDragging = true;
	
	switch(mySandboxSceneElementsLayer) {
		case ESandboxSceneElementsLayers.backgrounds:
			mySceneElementIns = SceneElement_CreateBackground(sprite_index);
			break;
	}
	
	gSandboxSceneElementsDragging = mySceneElementIns;
}

if(gSandboxSceneElementsDragging != noone && isDragging) {
	if(MouseLeftHold()) {
		
	} else {
		isDragging = false;
		gSandboxSceneElementsDragging = noone;
	}
}

// DebugMes([gSandboxSceneElementsLayer, gSandboxSceneElementsDragging, InstanceExists(gSandboxSceneElementsDragging), gSandboxGuiElementsDragObjIsOnRightClick]);