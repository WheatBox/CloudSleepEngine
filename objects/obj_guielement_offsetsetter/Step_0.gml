if(GUI_MouseGuiOnMe(left, top, right, bottom + bottomEdgeHeight)) {
	mouseOnMe = true;
	gMouseOnGUI = true;
} else {
	mouseOnMe = false;
	
	if(MouseLeftPressed() || MouseRightPressed()) {
		instance_destroy(id);
	}
}

if(inited) {
	var myoffxStr = string_digits(textbox_return(xTextboxIns));
	var myoffyStr = string_digits(textbox_return(yTextboxIns));

	myoffx = (string_length(myoffxStr) > 0) ? real(myoffxStr) : 0;
	myoffy = (string_length(myoffyStr) > 0) ? real(myoffyStr) : 0;

	if(GUI_MouseGuiOnMe(spriteLeft, spriteTop, spriteRight, spriteBottom)) {
		if(MouseLeftHold()) {
			myoffx = round((GetPositionXOnGUI(mouse_x) - spriteLeft) / xscale);
			myoffy = round((GetPositionYOnGUI(mouse_y) - spriteTop) / yscale);
		}
	}
	
	if((xTextboxIns.curt.fo || yTextboxIns.curt.fo) == false) {
		MySynchXYTextbox();
	}
}

