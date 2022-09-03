image_blend = c_white;

if(gSandboxSceneElementsDragging == id && isDragging == false) {
	isDragging = true;
	
	dragOffx = mouse_x - x;
	dragOffy = mouse_y - y;
}

if(isDragging) {
	gSandboxSceneElementsDragging = id;
	
	x = mouse_x - dragOffx;
	y = mouse_y - dragOffy;
	
	if(gSceneElementsGridAlignmentEnable) {
		x = GetPositionXGridStandardization(x);
		y = GetPositionYGridStandardization(y);
	}
	
	if(MouseLeftHold() == false) {
		gSandboxSceneElementsDragging = noone;
		isDragging = false;
	}
	
	if(InstanceExists(obj_sandboxSceneElementsDeleteArea)) {
		var toDelL = obj_sandboxSceneElementsDeleteArea.myLeft;
		var toDelT = obj_sandboxSceneElementsDeleteArea.myTop;
		var toDelR = obj_sandboxSceneElementsDeleteArea.myRight;
		var toDelB = obj_sandboxSceneElementsDeleteArea.myBottom;
		if(GUI_MouseGuiOnMe(toDelL, toDelT, toDelR, toDelB)) {
			image_blend = GUIDangerousColor;
			obj_sandboxSceneElementsDeleteArea.sceneElementOnMe = true;
			
			if(isDragging == false) {
				instance_destroy(id);
			}
		}
	}
}

/*
if(sprite_exists(sprite_index) && isDragging == false && !InstanceExists(gSandboxSceneElementsDragging)) {
	var offx = sprite_get_xoffset(sprite_index);
	var offy = sprite_get_yoffset(sprite_index);
	
	var _width = sprite_get_width(sprite_index);
	var _height = sprite_get_height(sprite_index);
	
	var toL = x - offx;
	var toR = x + _width - offx;
	var toT = y - offy;
	var toB = y + _height - offy;
	if(SCENE_MouseOnMe(toL, toT, toR, toB)) {
		if(MouseLeftPressed()) {
			gSandboxSceneElementsDragging = id;
		}
	}
}
*/
