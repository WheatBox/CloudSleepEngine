isDragging = false;

dragOffx = 0;
dragOffy = 0;

materialId = -1;

mygSceneStructI = -1;

inited = false;


basex = x;
basey = y;

offsetx = 0;
offsety = 0;


visible = false;
alarm_set(0, 1);


myColorRedFrames = 0;
MySetColorRed = function() {
	myColorRedFrames = 1;
	image_blend = GUIDangerousColor;
}

