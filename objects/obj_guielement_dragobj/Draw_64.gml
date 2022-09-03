SaveDrawSettings();

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
		
		var _btDeleteStr = "是否决定删除 " + myFilename;
		myDeleteButtonIns = GuiElement_CreateButton(
			GetPositionXOnGUI(mouse_x) + string_width(_btDeleteStr) / 2 + 12
			, GetPositionYOnGUI(mouse_y) + string_height(_btDeleteStr) / 2 + 12
			, _btDeleteStr
			, function() { MyDelete(); }
			, true
			, GUIDangerousColor
		);
		myDeleteButtonIns.depth = depth - 1;
	}
}

if(myDeleteButtonIns != noone) {
	if(InstanceExists(myDeleteButtonIns) == false) {
		instance_destroy(myDeleteButtonIns);
		myDeleteButtonIns = noone;
		gSandboxGuiElementsDragObjIsOnRightClick = false;
	}
}

LoadDrawSettings();

