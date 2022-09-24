for(var i = 0; i < vecMyGuiElements.size(); i++) {
	if(InstanceExists(vecMyGuiElements.Container[i])) {
		instance_destroy(vecMyGuiElements.Container[i]);
	}
}

delete vecMyGuiElements;

