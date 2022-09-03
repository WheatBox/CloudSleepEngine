myFilename = "";

width = 256;
height = 256;

mouseOnMe = false;

isDragging = false;
mySceneElementIns = noone; // 拖拽出来的物体

myDeleteButtonIns = noone; // 我的删除按钮

masterPage = noone;

mySandboxSceneElementsLayer = ESandboxSceneElementsLayers.nothing;

MyDelete = function() {
	instance_destroy(id);
	
	if(masterPage != noone && InstanceExists(masterPage)) {
		var myIOnStruct = -1;
		var myIOnStructLen = array_length(gBackgroundsStruct.filename);
		for(var i = 0; i < myIOnStructLen; i++) {
			if(gBackgroundsStruct.filename[i] == myFilename) {
				myIOnStruct = i;
			}
		}
		
		var myIOnMasterPage = -1;
		var myIOnMasterPageLen = masterPage.vecChildElements.size();
		for(var i = 0; i < myIOnMasterPageLen; i++) {
			if(masterPage.vecChildElements.Container[i] == id) {
				myIOnMasterPage = i;
			}
		}
		
		if(myIOnMasterPage != -1) {
			GuiElement_PageClearIns(masterPage, myIOnMasterPage, 0);
			GuiElement_PageAlign(masterPage);
			
			if(myIOnStruct != -1) {
				switch(mySandboxSceneElementsLayer) {
					case ESandboxSceneElementsLayers.backgrounds:
						array_delete(gBackgroundsStruct.filename, myIOnStruct, 1);
						array_delete(gBackgroundsSpritesStruct.sprites, myIOnStruct, 1);
						var _jsonTemp = json_stringify(gBackgroundsStruct);
						
						FileWrite(WORKFILEPATH + FILEJSON_backgrounds, _jsonTemp);
						
						FileRemove(WORKFILEPATH + FILEPATH_backgrounds + myFilename);
						break;
				}
			}
		}
	}
}

