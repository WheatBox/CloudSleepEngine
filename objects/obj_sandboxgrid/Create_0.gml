// 网格的格子数量
// 实际大小（单位：像素） = ((right - left) * cellSize) * ((bottom - top) * cellSize)
/*left = gSceneStruct.left;
top = gSceneStruct.top;
right = gSceneStruct.right;
bottom = gSceneStruct.bottom;*/

lineWidth = 2;

cellSize = SCENE_CellSize;

// 可拖动的角标的大小（的一半）
draggerRadius = 12;

// 0 左上，1 右上，2 左下，3 右下，-1 无
draggerIdMouseOn = -1;

mouseIsDragging = false;


gridSurf = -1;
gridSurfWidth = 8192;
gridSurfHeight = 8192;

MyCheckAndCreateGridSurf = function() {
	if(gridSurf == -1 || surface_exists(gridSurf) == false) {
		MyRemakeGridSurf();
	}
}
show_debug_overlay(1);
MyRemakeGridSurf = function() {
	var _w = gridSurfWidth + lineWidth + 1, _h = gridSurfHeight + lineWidth + 1;
	if(gridSurf != -1 && surface_exists(gridSurf)) {
		surface_free(gridSurf);
		gridSurf = surface_create(_w, _h);
	}
	gridSurf = surface_create(_w, _h);
	
	surface_set_target(gridSurf);
	
	draw_set_color(c_black);
	draw_set_alpha(1.0);
	
	// 画横线
	for(var iy = 0; iy <= _h / cellSize; iy++) {
		draw_line_width(0, iy * cellSize, _w, iy * cellSize, lineWidth);
	}
	// 画竖线
	for(var ix = 0; ix <= _w / cellSize; ix++) {
		draw_line_width(ix * cellSize, 0, ix * cellSize, _h, lineWidth);
	}
	
	draw_set_color(c_white);
	draw_set_alpha(1.0);
	
	surface_reset_target();
}

