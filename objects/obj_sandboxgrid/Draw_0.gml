SaveDrawSettings();

draw_set_color(c_black);

if(gSceneElementsGridAlignmentEnable == false)
	draw_set_alpha(0.05);
else
	draw_set_alpha(0.2);

var leftPixel = gSceneStruct.left * cellSize;
var rightPixel = gSceneStruct.right * cellSize;
var topPixel = gSceneStruct.top * cellSize;
var bottomPixel = gSceneStruct.bottom * cellSize;

// 画横线
for(var iy = gSceneStruct.top; iy <= gSceneStruct.bottom; iy++) {
	draw_line_width(leftPixel, iy * cellSize, rightPixel, iy * cellSize, lineWidth);
}
// 画竖线
for(var ix = gSceneStruct.left; ix <= gSceneStruct.right; ix++) {
	draw_line_width(ix * cellSize, topPixel, ix * cellSize, bottomPixel, lineWidth);
}

LoadDrawSettings();
