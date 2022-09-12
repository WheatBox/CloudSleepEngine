if(window_get_cursor() == cr_handpoint) {
	window_set_cursor(cr_default);
}

var w = window_get_width();
var h = window_get_height();

if(w != windowWidth || h != windowHeight) {
	DebugMes(["WindowResize", w, h]);
	
	surface_resize(application_surface, w, h);
	
	camera_set_view_size(view_camera[0], w * CameraScale(), h * CameraScale());
	
	windowWidth = w;
	windowHeight = h;
}

