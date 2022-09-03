globalvar InitCameraPosX, InitCameraPosY;
InitCameraPosX = 640;
InitCameraPosY = 360;

enum ESandboxSceneElementsLayers {
	nothing,
	backgrounds,
	decorates,
	beds
};

globalvar gSandboxSceneElementsLayer, gSandboxSceneElementsDragging;
gSandboxSceneElementsLayer = ESandboxSceneElementsLayers.nothing;
gSandboxSceneElementsDragging = noone;

// GUI中的 obj_GuiElment_DragObj 是否有被右键选中
globalvar gSandboxGuiElementsDragObjIsOnRightClick;
gSandboxGuiElementsDragObjIsOnRightClick = false;
