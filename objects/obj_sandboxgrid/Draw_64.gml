if(gSceneElementsGridAlignmentEnable == false) {
	exit;
}

SaveDrawSettings();

var leftPixel = left * cellSize;
var rightPixel = right * cellSize;
var topPixel = top * cellSize;
var bottomPixel = bottom * cellSize;

draw_set_color(GUIDefaultColor);
draw_set_color(GUIDefaultAlpha);

SCENE_DrawRectangleOnGui_Radius(leftPixel, topPixel, draggerRadius, false);
SCENE_DrawRectangleOnGui_Radius(rightPixel, topPixel, draggerRadius, false);
SCENE_DrawRectangleOnGui_Radius(leftPixel, bottomPixel, draggerRadius, false);
SCENE_DrawRectangleOnGui_Radius(rightPixel, bottomPixel, draggerRadius, false);

draw_set_color(c_white);
draw_set_alpha(GUIHighLightAlpha);
if(draggerIdMouseOn != -1) {
	var _x = 0;
	var _y = 0;
	if(draggerIdMouseOn == 0) { _x = leftPixel; _y = topPixel; }
	if(draggerIdMouseOn == 1) { _x = rightPixel; _y = topPixel; }
	if(draggerIdMouseOn == 2) { _x = leftPixel; _y = bottomPixel; }
	if(draggerIdMouseOn == 3) { _x = rightPixel; _y = bottomPixel; }
	SCENE_DrawRectangleOnGui_Radius(_x, _y, draggerRadius, false);
}

LoadDrawSettings();

