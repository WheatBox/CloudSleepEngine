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

if(surface_exists(surfSleepersSprites) == false) {
	surfSleepersSprites = MyCreateSurfSleepersSprites();
}
GUI_DrawSurface(surfSleepersSprites, xoff, 0 - scrollY);



xoff += myImageMinimumWidthHeight + arrowXAddBegin + arrowXAddEnd + 16 + myImageMinimumWidthHeight / 2;

mouseOnBedSleepIndex = -1;

for(var i = 0; i < array_length(gSleepersStruct.materials); i++) {
	var _yTemp = 0 - scrollY + (i * (myImageMinimumWidthHeight + sleepersSpritesSpacing)) + myImageMinimumWidthHeight / 2;
	
	if(mouseOnBedSleepIndex == -1) {
		if(GUI_MouseGuiOnMe(xoff - myImageMinimumWidthHeight / 2, _yTemp - myImageMinimumWidthHeight / 2, xoff + myImageMinimumWidthHeight / 2, _yTemp + myImageMinimumWidthHeight / 2)) {
			mouseOnBedSleepIndex = i;
		}
	}
	
	var _canDrawImportBt = true;
	if(CheckStructCanBeUse(arrBedSleepStructs[i])) {
		var _sprTemp = arrBedSleepStructs[i].sprite;
		if(sprite_exists(_sprTemp)) {
			_canDrawImportBt = false;
			
			var _scalesTemp;
			if(sprite_get_width(_sprTemp) > sprite_get_height(_sprTemp)) {
				_scalesTemp = SetSizeLockAspect_Width_Generic(myImageMinimumWidthHeight, sprite_get_width(_sprTemp));
			} else {
				_scalesTemp = SetSizeLockAspect_Height_Generic(myImageMinimumWidthHeight, sprite_get_height(_sprTemp));
			}
			GUI_DrawSprite_ext(_sprTemp, 0, xoff, _yTemp, _scalesTemp[0], _scalesTemp[1], 0, c_white, 1.0);
		}
	}
	if(_canDrawImportBt) {
		GUI_DrawLabel_ext("未定义\n点我导入", xoff, _yTemp, myImageMinimumWidthHeight / 2, myImageMinimumWidthHeight / 2, i == mouseOnBedSleepIndex);
	}
}

