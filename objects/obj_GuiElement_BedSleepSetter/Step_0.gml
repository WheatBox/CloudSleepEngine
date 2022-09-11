if(GUI_MouseGuiOnMe(left, top, right, bottom)) {
	mouseOnMe = true;
	gMouseOnGUI = true;
} else {
	mouseOnMe = false;
	
	if(MouseLeftPressed() || MouseRightPressed()) {
		instance_destroy(id);
	}
}

if(mouseOnMe) {
	if(mouse_wheel_up()) {
		if(scrollY > 0) {
			scrollY -= scrollYSpeed;
		}
	} else if(mouse_wheel_down()) {
		if(CheckStructCanBeUse(gSleepersStruct))
		if(scrollY + scrollYSpeed * 1 < (array_length(gSleepersStruct.materials) - 1) * (myImageMinimumWidthHeight + sleepersSpritesSpacing)) {
			scrollY += scrollYSpeed;
		}
	}
}

if(mouseOnBedSleepIndex != -1) {
	var _canImport = true;
	if(CheckStructCanBeUse(arrBedSleepStructs[mouseOnBedSleepIndex])) {
		if(sprite_exists(arrBedSleepStructs[mouseOnBedSleepIndex].sprite)) {
			_canImport = false;
		}
	}
	if(_canImport) {
		if(MouseLeftPressed()) {
			MyImportBedSleep(mouseOnBedSleepIndex);
		}
	} else {
		if(MouseRightPressed()) {
			var buttonsOffsetX = GetPositionXOnGUI(mouse_x) + 12;
			var buttonsOffsetY = GetPositionYOnGUI(mouse_y) + 12;
			
			var _btDeleteStr = "删除 " + GetNameFromFileName(arrBedSleepStructs[mouseOnBedSleepIndex].filename, true);
			myDeleteButtonIns = GuiElement_CreateButton_ext(
				buttonsOffsetX - string_width(_btDeleteStr) / 2
				, buttonsOffsetY + string_height(_btDeleteStr) / 2
				, _btDeleteStr
				, ,
				, [mouseOnBedSleepIndex]
				, function(args) {
					MyDeleteSprite(args[0]);
					gSandboxGuiElementsDragObjIsOnRightClick = false;
				}
				, true, GUIDangerousColor
			);
			// myDeleteButtonIns.depth = depth - 1;
			myDeleteButtonIns.depth = GUIDragObjDepth - 1;
		}
	}
}

if(myDeleteButtonIns != noone) {
	if(InstanceExists(myDeleteButtonIns) == false) {
		myDeleteButtonIns = noone;
		gSandboxGuiElementsDragObjIsOnRightClick = false;
	}
}

