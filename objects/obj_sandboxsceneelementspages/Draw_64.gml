// SaveDrawSettings();

draw_set_color(GUIDefaultColor);
draw_set_alpha(0.4);
GUI_DrawRectangle(x, y - btHeight / 2 - 16, x + myWidth, y + myHeight);

if(GUI_MouseGuiOnMe(x, y - btHeight / 2 - 16, x + myWidth, y + myHeight)) {
	gMouseOnGUI = true;
}

// LoadDrawSettings();

