// SaveDrawSettings();

draw_set_color(GUIDefaultColor);
draw_set_alpha(labelAlpha);
GUI_DrawRectangle(x, y, x + width, y + 32);

draw_set_color(c_white);
GUI_DrawText(x + width / 2, y + string_height(labelText) / 2, labelText, true);

// LoadDrawSettings();
