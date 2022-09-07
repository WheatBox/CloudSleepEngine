// SaveDrawSettings();

draw_set_alpha(1.0);
draw_set_color(c_white);
GUI_DrawSprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

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
			case ESandboxSceneElementsLayers.decorates:
				materialMasterArr = gDecoratesStruct.materials;
				break;
			case ESandboxSceneElementsLayers.beds:
				materialMasterArr = gBedsStruct.materials;
				break;
		}
		switch(mySandboxSceneElementsLayer) {
			case ESandboxSceneElementsLayers.decorates:
			case ESandboxSceneElementsLayers.beds:
				var newbtStr = "";
				var newins = noone;
				
				newbtStr = "更改物体中心点";
				newins = GuiElement_CreateButton(buttonsOffsetX + string_width(newbtStr) / 2, buttonsOffsetY + string_height(newbtStr) / 2, newbtStr, function() { GuiElement_CreateOffsetSetter(materialMasterArr, materialId, sprite_index); gSandboxGuiElementsDragObjIsOnRightClick = false; }, true);
				newins.depth = depth - 1;
				
				buttonsOffsetY += 36;
				
				break;
		}
		
		var _btDeleteStr = "是否决定删除 " + myFilename;
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

