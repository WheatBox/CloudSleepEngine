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
gridSurfWidth = 2048;
gridSurfHeight = 2048;

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
		draw_line_width(0, iy * cellSize, _w - 2, iy * cellSize, lineWidth);
	}
	// 画竖线
	for(var ix = 0; ix <= _w / cellSize; ix++) {
		draw_line_width(ix * cellSize, 0, ix * cellSize, _h - 2, lineWidth);
	}
	
	draw_set_color(c_white);
	draw_set_alpha(1.0);
	
	surface_reset_target();
}

cameraXPrev = CameraX();
cameraYPrev = CameraY();

mpGridHitboxDraw = -1;


gridHitboxSurf = -1;
gridHitboxSurfWidth = 1;
gridHitboxSurfHeight = 1;

MyCheckAndCreateGridHitboxSurf = function() {
	if(gridHitboxSurf == -1 || surface_exists(gridHitboxSurf) == false) {
		MyRemakeGridHitboxSurf();
	}
}

MyRemakeGridHitboxSurf = function() {
	gridHitboxSurfWidth = GuiWidth();
	gridHitboxSurfHeight = GuiHeight();
	
	var _w = gridHitboxSurfWidth, _h = gridHitboxSurfHeight;
	if(gridHitboxSurf != -1 && surface_exists(gridHitboxSurf)) {
		surface_free(gridHitboxSurf);
	}
	gridHitboxSurf = surface_create(_w, _h);
	
	surface_set_target(gridHitboxSurf);
	
	DebugMes([surface_get_width(gridHitboxSurf), surface_get_height(gridHitboxSurf)]);
	
	draw_set_alpha(1.0);
	
	var _xoff = GetPositionXOnGUI(gSceneStruct.left * cellSize);
	var _yoff = GetPositionYOnGUI(gSceneStruct.top * cellSize);
	
	var _drawScale = 1 / CameraScale();
	
	var _surflTemp = 0;
	var _surftTemp = 0;
	var _surfrTemp = _surflTemp + CameraWidth();
	var _surfbTemp = _surftTemp + CameraHeight();
	
	var _colPrev = undefined;
	
	for(var iy = gSceneStruct.top; iy < gSceneStruct.bottom; iy++) {
		var _ttemp = _yoff + (iy - gSceneStruct.top) * cellSize * _drawScale;
		var _btemp = _yoff + ((iy - gSceneStruct.top + 1) * cellSize - 1) * _drawScale;
		
		if(_ttemp > _surfbTemp || _btemp < _surftTemp) {
			continue;
		}
		
		for(var ix = gSceneStruct.left; ix < gSceneStruct.right; ix++) {
			var _ltemp = _xoff + (ix - gSceneStruct.left) * cellSize * _drawScale;
			var _rtemp = _xoff + ((ix - gSceneStruct.left + 1) * cellSize - 1) * _drawScale;
			
			if(_ltemp > _surfrTemp || _rtemp < _surflTemp) {
				continue;
			}
			
			var _colNext = (mp_grid_get_cell(mpGridHitboxDraw, (ix - gSceneStruct.left), (iy - gSceneStruct.top)) == 0)
				? c_lime
				: c_red;
			
			if(_colNext != _colPrev) {
				draw_set_color(_colNext);
				_colPrev = _colNext;
			}
			draw_rectangle(_ltemp, _ttemp, _rtemp, _btemp, false);
		}
	}
	
	draw_set_color(c_white);
	
	surface_reset_target();
}

