GUI_SetCursorDefault();

var w = window_get_width();
var h = window_get_height();


if((w != windowWidth || h != windowHeight) && surface_exists(application_surface) && (w != 0 && h != 0)) {
	DebugMes(["WindowResize", w, h]);
	
	surface_resize(application_surface, w, h);
	
	camera_set_view_size(view_camera[0], w * CameraScale(), h * CameraScale());
	
	windowWidth = w;
	windowHeight = h;
}


InstancesOptimize();
