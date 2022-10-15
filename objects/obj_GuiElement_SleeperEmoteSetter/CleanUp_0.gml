for(var i = 0; i < array_length(arrSleeperEmoteStructs); i++) {
	if(CheckStructCanBeUse(arrSleeperEmoteStructs[i])) {
		if(sprite_exists(arrSleeperEmoteStructs[i].sprite)) {
			sprite_delete(arrSleeperEmoteStructs[i].sprite);
		}
		delete arrSleeperEmoteStructs[i];
	}
}

