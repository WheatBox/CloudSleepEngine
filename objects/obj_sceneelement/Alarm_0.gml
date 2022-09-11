visible = true;

if(sprite_exists(sprite_index)) {
	offsetx = sprite_get_xoffset(sprite_index);
	offsety = sprite_get_yoffset(sprite_index);
	x = basex + sprite_get_width(sprite_index) / 2 - offsetx;
	y = basey + sprite_get_height(sprite_index) / 2 - offsety;
}

