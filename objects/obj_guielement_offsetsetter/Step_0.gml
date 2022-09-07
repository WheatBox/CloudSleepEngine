if(GUI_MouseGuiOnMe(left, top, right, bottom + bottomEdgeHeight)) {
	mouseOnMe = true;
	gMouseOnGUI = true;
} else {
	mouseOnMe = false;
	
	if(MouseLeftPressed() || MouseRightPressed()) {
		instance_destroy(id);
	}
}

if(GUI_MouseGuiOnMe(spriteLeft, spriteTop, spriteRight, spriteBottom)) {
	if(MouseLeftHold()) {
		myoffx = round((GetPositionXOnGUI(mouse_x) - spriteLeft) / xscale);
		myoffy = round((GetPositionYOnGUI(mouse_y) - spriteTop) / yscale);
	}
}

