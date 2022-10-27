// SaveDrawSettings();

draw_set_alpha(1.0);
draw_set_color(c_white);
GUI_DrawSprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

if(mySandboxSceneElementsLayer == ESandboxSceneElementsLayers.beds) {
	var _dragObjBedsCountGetRes = string(DragObjBedsCountGet(materialId));
	
	draw_set_alpha(0.5);
	draw_set_color(c_black);
	GUI_DrawRectangle(x - width / 2, y - height / 2, x - width / 2 + string_width(_dragObjBedsCountGetRes), y - height / 2 + string_height(_dragObjBedsCountGetRes), false);
	
	draw_set_color(c_white);
	GUI_DrawText(
		x - width / 2, y - height / 2
		, _dragObjBedsCountGetRes
		, false
	);
}

if(mouseOnMe) {
	gMouseOnGUI = true;
	draw_set_alpha(GUIHighLightAlpha);
	GUI_DrawRectangle(x - width / 2, y - height / 2, x + width / 2, y + height / 2);
	
	GUI_DrawLabel(myFilename, 
		GetPositionXOnGUI(mouse_x) + string_width(myFilename) / 2 + 12,
		GetPositionYOnGUI(mouse_y) + string_height(myFilename) / 2 + 12,
		false);
	
	// "删除"按钮
	if(MouseRightPressed() && !InstanceExists(gSandboxSceneElementsDragging)) {
		gSandboxGuiElementsDragObjIsOnRightClick = true;
		
		
		var buttonsOffsetX = GetPositionXOnGUI(mouse_x) + 12;
		var buttonsOffsetY = GetPositionYOnGUI(mouse_y) + 12;
		
		switch(mySandboxSceneElementsLayer) {
			case ESandboxSceneElementsLayers.sleepers:
				materialMasterArr = gSleepersStruct.materials;
				break;
			case ESandboxSceneElementsLayers.backgrounds:
				materialMasterArr = gBackgroundsStruct.materials;
				break;
			case ESandboxSceneElementsLayers.decorates:
				materialMasterArr = gDecoratesStruct.materials;
				break;
			case ESandboxSceneElementsLayers.beds:
				materialMasterArr = gBedsStruct.materials;
				break;
		}
		var newbtYAdd = 32;
		var newbtStr = "";
		var newins = noone;
		switch(mySandboxSceneElementsLayer) {
			case ESandboxSceneElementsLayers.sleepers:
			case ESandboxSceneElementsLayers.decorates:
			case ESandboxSceneElementsLayers.beds:
				
				newbtStr = "更改物体中心点";
				newins = GuiElement_CreateButton(buttonsOffsetX + string_width(newbtStr) / 2, buttonsOffsetY + string_height(newbtStr) / 2, newbtStr, function() { GuiElement_CreateOffsetSetter(materialMasterArr, materialId, sprite_index); gSandboxGuiElementsDragObjIsOnRightClick = false; }, true);
				newins.depth = depth - 1;
				
				buttonsOffsetY += newbtYAdd;
				
		}
		switch(mySandboxSceneElementsLayer) {
			case ESandboxSceneElementsLayers.decorates:
			case ESandboxSceneElementsLayers.beds:
				newbtStr = "更改物体碰撞体积";
				newins = GuiElement_CreateButton(buttonsOffsetX + string_width(newbtStr) / 2, buttonsOffsetY + string_height(newbtStr) / 2, newbtStr, function() { GuiElement_CreateHitboxSetter(materialMasterArr, materialId, sprite_index); gSandboxGuiElementsDragObjIsOnRightClick = false; }, true);
				newins.depth = depth - 1;
				
				buttonsOffsetY += newbtYAdd;
				
				break;
		}
		switch(mySandboxSceneElementsLayer) {
			case ESandboxSceneElementsLayers.sleepers:
				newbtStr = "编辑睡客表情包";
				newins = GuiElement_CreateButton(buttonsOffsetX + string_width(newbtStr) / 2, buttonsOffsetY + string_height(newbtStr) / 2, newbtStr, function() { GuiElement_CreateSleeperEmoteSetter(/*materialMasterArr, */materialId, sprite_index); gSandboxGuiElementsDragObjIsOnRightClick = false; }, true);
				newins.depth = depth - 1;
				
				buttonsOffsetY += newbtYAdd;
				
				break;
				
			case ESandboxSceneElementsLayers.beds:
				newbtStr = "编辑睡客互动";
				newins = GuiElement_CreateButton(buttonsOffsetX + string_width(newbtStr) / 2, buttonsOffsetY + string_height(newbtStr) / 2, newbtStr, function() { GuiElement_CreateBedSleepSetter(/*materialMasterArr, */materialId, sprite_index); gSandboxGuiElementsDragObjIsOnRightClick = false; }, true);
				newins.depth = depth - 1;
				
				buttonsOffsetY += newbtYAdd;
				
				break;
		}
		
		var _btDeleteStr = "删除 " + myFilename;
		myDeleteButtonIns = GuiElement_CreateButton(buttonsOffsetX + string_width(_btDeleteStr) / 2, buttonsOffsetY + string_height(_btDeleteStr) / 2, _btDeleteStr, function() { MyDelete(); gSandboxGuiElementsDragObjIsOnRightClick = false; }, true, GUIDangerousColor);
		myDeleteButtonIns.depth = depth - 1;
	}
}

if(myDeleteButtonIns != noone) {
	if(InstanceExists(myDeleteButtonIns) == false) {
		myDeleteButtonIns = noone;
		gSandboxGuiElementsDragObjIsOnRightClick = false;
	}
}

// LoadDrawSettings();

