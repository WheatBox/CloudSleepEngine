var _camx = CameraX();
var _camy = CameraY();
var _camScale = CameraScale();

if(camxPrevious != _camx || camyPrevious != _camy) {
	MyFreeSurf();
	
	camxPrevious = _camx;
	camyPrevious = _camy;
}

MySurfCheckAndRemake();

if(mysurf != -1) {
	if(surface_exists(mysurf)) {
		draw_surface_ext(mysurf, _camx, _camy, _camScale, _camScale, 0, c_white, 1.0);
	}
}