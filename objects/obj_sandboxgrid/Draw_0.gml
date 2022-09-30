// SaveDrawSettings();
/*
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
*/
// LoadDrawSettings();

MyCheckAndCreateGridSurf();
if(surface_exists(gridSurf)) {
	var leftPixel = gSceneStruct.left * cellSize;
	var rightPixel = gSceneStruct.right * cellSize;
	var topPixel = gSceneStruct.top * cellSize;
	var bottomPixel = gSceneStruct.bottom * cellSize;
	
	for(var iy = gSceneStruct.top; iy < gSceneStruct.bottom; iy += gridSurfHeight / cellSize) {
		for(var ix = gSceneStruct.left; ix < gSceneStruct.right; ix += gridSurfWidth / cellSize) {
			var _wAddTemp = 0;
			var _hAddTemp = 0;
			
			// 是否为横向上最后一个
			if(ix + gridSurfWidth / cellSize > gSceneStruct.right) {
				_wAddTemp = lineWidth / 2 + 1;
			}
			
			// 是否为纵向上最后一个
			if(iy + gridSurfHeight / cellSize > gSceneStruct.bottom) {
				_hAddTemp = lineWidth / 2 + 1;
			}
			
			draw_surface_part_ext(gridSurf
				, 0, 0, (gSceneStruct.right - ix) * cellSize + _wAddTemp, (gSceneStruct.bottom - iy) * cellSize + _hAddTemp
				, ix * cellSize, iy * cellSize
				, 1, 1, c_white
				, gSceneElementsGridAlignmentEnable == false ? 0.05 : 0.2);
		}
	}
}
