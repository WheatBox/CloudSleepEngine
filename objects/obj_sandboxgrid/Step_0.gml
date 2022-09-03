var leftPixel = left * cellSize;
var rightPixel = right * cellSize;
var topPixel = top * cellSize;
var bottomPixel = bottom * cellSize;

if(gMouseOnGUI == false && mouseIsDragging == false) {
	if(SCENE_MouseOnMe_Radius(leftPixel, topPixel, draggerRadius * CameraScale())) {
		draggerIdMouseOn = 0;
	} else
	if(SCENE_MouseOnMe_Radius(rightPixel, topPixel, draggerRadius * CameraScale())) {
		draggerIdMouseOn = 1;
	} else
	if(SCENE_MouseOnMe_Radius(leftPixel, bottomPixel, draggerRadius * CameraScale())) {
		draggerIdMouseOn = 2;
	} else
	if(SCENE_MouseOnMe_Radius(rightPixel, bottomPixel, draggerRadius * CameraScale())) {
		draggerIdMouseOn = 3;
	} else {
		draggerIdMouseOn = -1;
	}
}

if(draggerIdMouseOn != -1) {
	gMouseOnGUI = true;
	if(MouseLeftHold()) {
		mouseIsDragging = true;
		
		gMouseOnGUI = true;
		
		var mx = GetPositionXGridStandardization(mouse_x, cellSize);
		var my = GetPositionYGridStandardization(mouse_y, cellSize);
		
		switch(draggerIdMouseOn) {
			case 0:
				left = floor(mx / cellSize);
				top = floor(my / cellSize);
				break;
			case 1:
				right = floor(mx / cellSize);
				top = floor(my / cellSize);
				break;
			case 2:
				left = floor(mx / cellSize);
				bottom = floor(my / cellSize);
				break;
			case 3:
				right = floor(mx / cellSize);
				bottom = floor(my / cellSize);
				break;
		}
	} else {
		mouseIsDragging = false;
	}
}

