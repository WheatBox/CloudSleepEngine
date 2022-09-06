var leftPixel = gSceneStruct.left * cellSize;
var rightPixel = gSceneStruct.right * cellSize;
var topPixel = gSceneStruct.top * cellSize;
var bottomPixel = gSceneStruct.bottom * cellSize;

if(gMouseOnGUI == false && mouseIsDragging == false && InstanceExists(gSandboxSceneElementsDragging) == false) {
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
				gSceneStruct.left = floor(mx / cellSize);
				gSceneStruct.top = floor(my / cellSize);
				
				gSceneStruct.left = clamp(gSceneStruct.left, -infinity, gSceneStruct.right - 10);
				gSceneStruct.top = clamp(gSceneStruct.top, -infinity, gSceneStruct.bottom - 10);
				
				break;
			case 1:
				gSceneStruct.right = floor(mx / cellSize);
				gSceneStruct.top = floor(my / cellSize);
				
				gSceneStruct.right = clamp(gSceneStruct.right, gSceneStruct.left + 10, infinity);
				gSceneStruct.top = clamp(gSceneStruct.top, -infinity, gSceneStruct.bottom - 10);
				
				break;
			case 2:
				gSceneStruct.left = floor(mx / cellSize);
				gSceneStruct.bottom = floor(my / cellSize);
				
				gSceneStruct.left = clamp(gSceneStruct.left, -infinity, gSceneStruct.right - 10);
				gSceneStruct.bottom = clamp(gSceneStruct.bottom, gSceneStruct.top + 10, infinity);
				
				break;
			case 3:
				gSceneStruct.right = floor(mx / cellSize);
				gSceneStruct.bottom = floor(my / cellSize);
				
				gSceneStruct.right = clamp(gSceneStruct.right, gSceneStruct.left + 10, infinity);
				gSceneStruct.bottom = clamp(gSceneStruct.bottom, gSceneStruct.top + 10, infinity);
				
				break;
		}
	} else {
		mouseIsDragging = false;
	}
}

