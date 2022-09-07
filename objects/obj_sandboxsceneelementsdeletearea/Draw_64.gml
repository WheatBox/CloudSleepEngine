// SaveDrawSettings();

if(InstanceExists(gSandboxSceneElementsDragging)) {
	myLeft = GuiWidth() - width;
	myTop = GuiHeight() - height;
	myRight = GuiWidth();
	myBottom = GuiHeight();
	
	GUI_DrawLabel_ext("拖住场景中的元素\n到此处以删除", myLeft + width / 2, myTop + height / 2, width / 2, height / 2,
		sceneElementOnMe, GUIDangerousColor);
}

sceneElementOnMe = false;

// LoadDrawSettings();
