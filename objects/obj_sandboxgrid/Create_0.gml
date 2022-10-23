// 网格的格子数量
// 实际大小（单位：像素） = ((right - left) * cellSize) * ((bottom - top) * cellSize)
/*left = gSceneStruct.left;
top = gSceneStruct.top;
right = gSceneStruct.right;
bottom = gSceneStruct.bottom;*/

// lineWidth = 2;
lineWidth = 1;

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

MyRemakeGridSurf = function() {
	var _w = gridSurfWidth + lineWidth + 1, _h = gridSurfHeight + lineWidth + 1;
	if(gridSurf != -1 && surface_exists(gridSurf)) {
		surface_free(gridSurf);
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

cameraXPrev = CameraX();
cameraYPrev = CameraY();

mpGridHitboxDraw = -1;

// 其实可以将这个做成一个存储surface的二维数组来使得无限延申的，但没有必要，外加上懒，就没做
// 或者是用 mp_grid_draw() 直接绘制，但是 mp_grid_draw() 这个函数的执行效率巨慢
gridHitboxSurf = -1;
gridHitboxSurfWidth = 16384;
gridHitboxSurfHeight = 16384;

MyCheckAndCreateGridHitboxSurf = function() {
	if(gridHitboxSurf == -1 || surface_exists(gridHitboxSurf) == false) {
		MyRemakeGridHitboxSurf();
	}
}

MyRemakeGridHitboxSurf = function() {
	gridHitboxSurfWidth = min(16384, CameraWidth());
	gridHitboxSurfHeight = min(16384, CameraHeight());
	
	var _w = gridHitboxSurfWidth, _h = gridHitboxSurfHeight;
	if(gridHitboxSurf != -1 && surface_exists(gridHitboxSurf)) {
		surface_free(gridHitboxSurf);
	}
	gridHitboxSurf = surface_create(_w, _h);
	
	surface_set_target(gridHitboxSurf);
	
	DebugMes([surface_get_width(gridHitboxSurf), surface_get_height(gridHitboxSurf)]);
	
	draw_set_alpha(1.0);
	
	var _xoff = GetPositionXOnGUI(gSceneStruct.left * cellSize) * CameraScale();
	var _yoff = GetPositionYOnGUI(gSceneStruct.top * cellSize) * CameraScale();
	
	for(var iy = gSceneStruct.top; iy < gSceneStruct.bottom; iy++) {
		for(var ix = gSceneStruct.left; ix < gSceneStruct.right; ix++) {
			draw_set_color(
				(mp_grid_get_cell(mpGridHitboxDraw, (ix - gSceneStruct.left), (iy - gSceneStruct.top)) == 0)
				? c_lime
				: c_red
			);
			draw_rectangle(_xoff + (ix - gSceneStruct.left) * cellSize, _yoff + (iy - gSceneStruct.top) * cellSize
				, _xoff + (ix - gSceneStruct.left + 1) * cellSize - 1, _yoff + (iy - gSceneStruct.top + 1) * cellSize - 1
				, false
			);
		}
	}
	
	draw_set_color(c_white);
	
	surface_reset_target();
}

