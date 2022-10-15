draw_set_color(GUIDefaultColor);
draw_set_alpha(GUIDefaultAlpha);

GUI_DrawRectangle(left, top, right, bottom, false);

draw_set_color(c_white);
draw_set_alpha(1.0);

var xoff = left + myImageMinimumWidthHeight / 2 + 64;

if(sprite != undefined && sprite_exists(sprite)) {
	var scaleTemp = SetSizeLockAspect_Width_Generic(myImageMinimumWidthHeight, sprite_get_width(sprite));
	GUI_DrawSprite_ext(sprite, 0, xoff, (top + bottom) / 2, scaleTemp[0], scaleTemp[1], 0, c_white, 1);
	xoff += 128;
}



xoff += 16 + myImageMinimumWidthHeight / 2;

mouseOnSleeperEmoteIndex = -1;

var _sleeperEmoteArrLen = array_length(arrSleeperEmoteStructs);
for(var i = 0; i <= _sleeperEmoteArrLen; i++) {
	var _yTemp = 0 - scrollY + (i * (myImageMinimumWidthHeight + emotesSpritesSpacing)) + myImageMinimumWidthHeight / 2;
	
	if(mouseOnSleeperEmoteIndex == -1) {
		if(GUI_MouseGuiOnMe(xoff - myImageMinimumWidthHeight / 2, _yTemp - myImageMinimumWidthHeight / 2, xoff + myImageMinimumWidthHeight / 2, _yTemp + myImageMinimumWidthHeight / 2)) {
			mouseOnSleeperEmoteIndex = i;
		}
	}
	
	if(i == _sleeperEmoteArrLen) {
		GUI_DrawLabel_ext("未定义\n点我导入", xoff, _yTemp, myImageMinimumWidthHeight / 2, myImageMinimumWidthHeight / 2, i == mouseOnSleeperEmoteIndex);
		break;
	}
	
	if(CheckStructCanBeUse(arrSleeperEmoteStructs[i])) {
		var _sprTemp = arrSleeperEmoteStructs[i].sprite;
		if(sprite_exists(_sprTemp)) {
			var _scalesTemp;
			if(sprite_get_width(_sprTemp) > sprite_get_height(_sprTemp)) {
				_scalesTemp = SetSizeLockAspect_Width_Generic(myImageMinimumWidthHeight, sprite_get_width(_sprTemp));
			} else {
				_scalesTemp = SetSizeLockAspect_Height_Generic(myImageMinimumWidthHeight, sprite_get_height(_sprTemp));
			}
			GUI_DrawSprite_ext(_sprTemp, 0, xoff, _yTemp, _scalesTemp[0], _scalesTemp[1], 0, c_white, 1.0);
		}
	}
}

