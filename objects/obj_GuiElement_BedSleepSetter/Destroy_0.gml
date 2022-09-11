if(surface_exists(surfSleepersSprites)) {
	surface_free(surfSleepersSprites);
}
for(var i = 0; i < array_length(arrBedSleepStructs); i++) {
	if(CheckStructCanBeUse(arrBedSleepStructs[i])) {
		if(sprite_exists(arrBedSleepStructs[i].sprite)) {
			sprite_delete(arrBedSleepStructs[i].sprite);
		}
		delete arrBedSleepStructs[i];
	}
}

