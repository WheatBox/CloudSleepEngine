if(materialId >= 0 && materialId < array_length(materialMasterArr)) {
	if(array_length(materialMasterArr[materialId].offset) >= 2) {
		myoffx = round(materialMasterArr[materialId].offset[0]);
		myoffy = round(materialMasterArr[materialId].offset[1]);
	} else {
		MyAutoSet();
	}
}

if(sprite != undefined && sprite_exists(sprite)) {
	var _scalesTemp;
	if(sprite_get_width(sprite) > sprite_get_height(sprite)) {
		_scalesTemp = SetSizeLockAspect_Width_Generic(myImageMinimumWidthHeight, sprite_get_width(sprite));
	} else {
		_scalesTemp = SetSizeLockAspect_Height_Generic(myImageMinimumWidthHeight, sprite_get_height(sprite));
	}
	
	xscale = _scalesTemp[0];
	yscale = _scalesTemp[1];
	
	spriteLeft = (left + right) / 2 - xscale * sprite_get_width(sprite) / 2;
	spriteTop = (top + bottom) / 2 - yscale * sprite_get_height(sprite) / 2;
	spriteRight = (left + right) / 2 + xscale * sprite_get_width(sprite) / 2;
	spriteBottom = (top + bottom) / 2 + yscale * sprite_get_height(sprite) / 2;
}

MySynchXYTextbox();


inited = true;

