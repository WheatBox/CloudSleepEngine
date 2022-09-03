SaveDrawSettings();

draw_set_color(c_black);

if(gSceneElementsGridAlignmentEnable == false)
	draw_set_alpha(0.05);
else
	draw_set_alpha(0.2);

var leftPixel = left * cellSize;
var rightPixel = right * cellSize;
var topPixel = top * cellSize;
var bottomPixel = bottom * cellSize;

// 画横线
for(var iy = top; iy <= bottom; iy++) {
	draw_line_width(leftPixel, iy * cellSize, rightPixel, iy * cellSize, lineWidth);
}
// 画竖线
for(var ix = left; ix <= right; ix++) {
	draw_line_width(ix * cellSize, topPixel, ix * cellSize, bottomPixel, lineWidth);
}

LoadDrawSettings();
