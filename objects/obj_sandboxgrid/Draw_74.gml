var _x = CameraX();
var _y = CameraY();

if(gGridShowHitBoxEnable) {
	if(_x != cameraXPrev || _y != cameraYPrev) {
		gGridShowHitBoxEnable = false;
		exit;
	}
	
	var _scale = 1; // / CameraScale();
	MyCheckAndCreateGridHitboxSurf();
	if(surface_exists(gridHitboxSurf)) {
		draw_surface_ext(
			gridHitboxSurf
			, 0
			, 0
			, _scale, _scale
			, 0, c_white, 0.2
		);
	}
	
	// DebugMes([_x, _y]);
}

cameraXPrev = _x;
cameraYPrev = _y;
