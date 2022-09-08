draw_set_color(GUIDefaultColor);
draw_set_alpha(GUIDefaultAlpha);

GUI_DrawRectangle(left, top, right, bottom, false);

draw_set_alpha(1.0);
GUI_DrawRectangle(left, bottom, right, bottom + bottomEdgeHeight, false);

if(sprite != undefined && sprite_exists(sprite)) {
	GUI_DrawSprite_ext(sprite, 0, (left + right) / 2, (top + bottom) / 2, xscale, yscale, 0, c_white, 1);
	
	
	var leftPixel = spriteLeft + myhitLeft * xscale;
	var topPixel = spriteTop + myhitTop * yscale;
	var rightPixel = spriteLeft + myhitRight * xscale;
	var bottomPixel = spriteTop + myhitBottom * yscale;
	
	draw_set_color(c_black);
	draw_set_alpha(0.4);
	
	GUI_DrawRectangle(leftPixel, topPixel, rightPixel, bottomPixel);
	
	draw_set_alpha(GUIDefaultAlpha);
	
	GUI_DrawRectangle_Radius(leftPixel, topPixel, draggerRadius, false);
	GUI_DrawRectangle_Radius(rightPixel, topPixel, draggerRadius, false);
	GUI_DrawRectangle_Radius(leftPixel, bottomPixel, draggerRadius, false);
	GUI_DrawRectangle_Radius(rightPixel, bottomPixel, draggerRadius, false);
	
	draw_set_color(c_white);
	draw_set_alpha(GUIHighLightAlpha);
	if(draggerIdMouseOn != -1) {
		var _x = 0;
		var _y = 0;
		if(draggerIdMouseOn == 0) { _x = leftPixel; _y = topPixel; }
		if(draggerIdMouseOn == 1) { _x = rightPixel; _y = topPixel; }
		if(draggerIdMouseOn == 2) { _x = leftPixel; _y = bottomPixel; }
		if(draggerIdMouseOn == 3) { _x = rightPixel; _y = bottomPixel; }
		GUI_DrawRectangle_Radius(_x, _y, draggerRadius, false);
	}
}

