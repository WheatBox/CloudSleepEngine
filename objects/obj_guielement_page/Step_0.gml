if(working == false) {
	visible = false;
} else {
	visible = true;
	
	if(GUI_MouseGuiOnMe(x, y, x + width, y + height)) {
		gMouseOnGUI = true;
	}
}

