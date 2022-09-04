SaveDrawSettings();

if(insMouseOn != noone && insMouseOn != undefined && instance_exists(insMouseOn)) {
	draw_set_color(GUIDefaultColor);
	draw_set_alpha(GUIDefaultAlpha);
	SCENE_DrawRectangleOnGui(insMouseOn.bbox_left, insMouseOn.bbox_top, insMouseOn.bbox_right, insMouseOn.bbox_bottom, true);
}

LoadDrawSettings();