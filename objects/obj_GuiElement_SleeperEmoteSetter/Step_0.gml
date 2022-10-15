left = GuiWidth() - width;
right = left + width;
bottom = GuiHeight();

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
		if(materialId >= 0 && materialId < array_length(gSleepersStruct.materials))
		if(CheckStructCanBeUse(gSleepersStruct.materials[materialId]))
		if(scrollY + scrollYSpeed * 1 < (array_length(gSleepersStruct.materials[materialId].emotefilenames) - 1) * (myImageMinimumWidthHeight + emotesSpritesSpacing)) {
			scrollY += scrollYSpeed;
		}
	}
}

if(mouseOnSleeperEmoteIndex != -1) {
	var _canImport = (mouseOnSleeperEmoteIndex == array_length(gSleepersStruct.materials[materialId].emotefilenames));
	//var _canImport = true;
	//if(CheckStructCanBeUse(arrSleeperEmoteStructs[mouseOnSleeperEmoteIndex])) {
	//	if(sprite_exists(arrSleeperEmoteStructs[mouseOnSleeperEmoteIndex].sprite)) {
	//		_canImport = false;
	//	}
	//}
	if(_canImport) {
		if(MouseLeftPressed()) {
			MyImportSleeperEmote(mouseOnSleeperEmoteIndex);
		}
	} else {
		if(MouseRightPressed()) {
			var buttonsOffsetX = GetPositionXOnGUI(mouse_x) + 12;
			var buttonsOffsetY = GetPositionYOnGUI(mouse_y) + 12;
			
			var _btDeleteStr = "删除 " + GetNameFromFileName(arrSleeperEmoteStructs[mouseOnSleeperEmoteIndex].filename, true);
			myDeleteButtonIns = GuiElement_CreateButton_ext(
				buttonsOffsetX - string_width(_btDeleteStr) / 2
				, buttonsOffsetY + string_height(_btDeleteStr) / 2
				, _btDeleteStr
				, ,
				, [mouseOnSleeperEmoteIndex]
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

