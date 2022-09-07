draw_set_color(GUIDefaultColor);
draw_set_alpha(GUIDefaultAlpha);

GUI_DrawRectangle(left, top, right, bottom, false);

draw_set_alpha(1.0);
GUI_DrawRectangle(left, bottom, right, bottom + bottomEdgeHeight, false);

if(sprite != undefined && sprite_exists(sprite)) {
	GUI_DrawSprite_ext(sprite, 0, (left + right) / 2, (top + bottom) / 2, xscale, yscale, 0, c_white, 1);
	
	var pointMidX = spriteLeft + myoffx * xscale;
	var pointMidY = spriteTop + myoffy * yscale;
	var pointMidSize = 2;
	var pointLineLen = 18;
	draw_set_color(c_white);
	draw_set_alpha(0.7);
	GUI_DrawRectangle(pointMidX - pointLineLen, pointMidY - pointMidSize, pointMidX - pointMidSize, pointMidY + pointMidSize, false);
	GUI_DrawRectangle(pointMidX + pointLineLen, pointMidY - pointMidSize, pointMidX + pointMidSize, pointMidY + pointMidSize, false);
	
	draw_set_color(c_black);
	GUI_DrawRectangle(pointMidX - pointLineLen, pointMidY - pointMidSize, pointMidX - pointMidSize, pointMidY + pointMidSize, true);
	GUI_DrawRectangle(pointMidX + pointLineLen, pointMidY - pointMidSize, pointMidX + pointMidSize, pointMidY + pointMidSize, true);
}

