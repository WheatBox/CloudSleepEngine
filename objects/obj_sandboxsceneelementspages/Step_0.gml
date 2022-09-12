if(sandboxSceneElementsLayerNeedRecheck) {
	sandboxSceneElementsLayerNeedRecheck = false;
	
	gSandboxSceneElementsLayer = ESandboxSceneElementsLayers.nothing;
	for(var i = 0; i < pages.size(); i++) {
		if(pages.Container[i].working) {
			switch(i) {
				case 0:
					gSandboxSceneElementsLayer = ESandboxSceneElementsLayers.sleepers;
					break;
				case 1:
					gSandboxSceneElementsLayer = ESandboxSceneElementsLayers.backgrounds;
					break;
				case 2:
					gSandboxSceneElementsLayer = ESandboxSceneElementsLayers.decorates;
					break;
				case 3:
					gSandboxSceneElementsLayer = ESandboxSceneElementsLayers.beds;
					break;
			}
		}
	}
}
// DebugMes(gSandboxSceneElementsLayer);

myHeight = GuiHeight() - y;
buttons.back().y = GuiHeight() - 16;
for(var i = 0; i < pages.size(); i++) {
	pages.Container[i].height = GuiHeight();
}

