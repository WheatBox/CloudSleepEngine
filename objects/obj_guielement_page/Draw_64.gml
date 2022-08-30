SaveDrawSettings();

draw_set_color(GUIDefaultColor);
draw_set_alpha(GUIDefaultAlpha);
GUI_DrawRectangle(x, y, x + width, y + height);

draw_set_color(c_white);
draw_set_alpha(1.0);
GUI_DrawText(x + width / 2, y + string_height(labelText) / 2, labelText, true);

LoadDrawSettings();

