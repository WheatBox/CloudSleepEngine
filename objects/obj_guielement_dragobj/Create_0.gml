myFilename = "";

materialMasterArr = undefined;
materialId = -1;

width = 256;
height = 256;

mouseOnMe = false;

isDragging = false;
mySceneElementIns = noone; // 拖拽出来的物体

myDeleteButtonIns = noone; // 我的删除按钮

masterPage = noone;

mySandboxSceneElementsLayer = ESandboxSceneElementsLayers.nothing;

MyDelete = function() {
	if(masterPage != noone && InstanceExists(masterPage)) {
		
		var _tempStruct = undefined;
		switch(mySandboxSceneElementsLayer) {
			case ESandboxSceneElementsLayers.sleepers:
				_tempStruct = gSleepersStruct;
				
				instance_activate_object(obj_SceneElementSleeper);
				break;
			case ESandboxSceneElementsLayers.backgrounds:
				_tempStruct = gBackgroundsStruct;
				
				instance_activate_object(obj_SceneElementBackground);
				break;
			case ESandboxSceneElementsLayers.decorates:
				_tempStruct = gDecoratesStruct;
				
				instance_activate_object(obj_SceneElementDecorate);
				break;
			case ESandboxSceneElementsLayers.beds:
				_tempStruct = gBedsStruct;
				
				instance_activate_object(obj_SceneElementBed);
				break;
		}
		if(_tempStruct == undefined) {
			return;
		}
		
		
		var myIOnStruct = -1;
		var myIOnStructLen = array_length(_tempStruct.materials);
		for(var i = 0; i < myIOnStructLen; i++) {
			if(_tempStruct.materials[i].filename == myFilename) {
				myIOnStruct = i;
			}
		}
		
		var myIOnMasterPage = -1;
		var myIOnMasterPageLen = masterPage.vecChildElements.size();
		for(var i = 0; i < myIOnMasterPageLen; i++) {
			if(masterPage.vecChildElements.Container[i] == id) {
				myIOnMasterPage = i;
				break;
			}
		}
		
		if(myIOnMasterPage != -1) {
			GuiElement_PageClearIns(masterPage, myIOnMasterPage, 0);
			
			switch(mySandboxSceneElementsLayer) {
				case ESandboxSceneElementsLayers.sleepers:
					SceneElement_ClearSleeperIns(myIOnMasterPage - 1, 1);
					break;
				case ESandboxSceneElementsLayers.backgrounds:
					SceneElement_ClearBackgroundIns(myIOnMasterPage - 1, 1);
					break;
				case ESandboxSceneElementsLayers.decorates:
					SceneElement_ClearDecorateIns(myIOnMasterPage - 1, 1);
					break;
				case ESandboxSceneElementsLayers.beds:
					SceneElement_ClearBedIns(myIOnMasterPage - 1, 1);
					break;
			}
			
			GuiElement_PageAlign(masterPage);
			
			var _jsonTemp = "";
			
			if(myIOnStruct != -1) {
				switch(mySandboxSceneElementsLayer) {
					case ESandboxSceneElementsLayers.sleepers:
						array_delete(gSleepersStruct.materials, myIOnStruct, 1);
						array_delete(gSleepersSpritesStruct.sprites, myIOnStruct, 1);
						_jsonTemp = json_stringify(gSleepersStruct);
						
						FileWrite(WORKFILEPATH + FILEJSON_sleepers, _jsonTemp);
						
						FileRemove(WORKFILEPATH + FILEPATH_sleepers + myFilename);
						break;
					case ESandboxSceneElementsLayers.backgrounds:
						array_delete(gBackgroundsStruct.materials, myIOnStruct, 1);
						array_delete(gBackgroundsSpritesStruct.sprites, myIOnStruct, 1);
						_jsonTemp = json_stringify(gBackgroundsStruct);
						
						FileWrite(WORKFILEPATH + FILEJSON_backgrounds, _jsonTemp);
						
						FileRemove(WORKFILEPATH + FILEPATH_backgrounds + myFilename);
						break;
					case ESandboxSceneElementsLayers.decorates:
						array_delete(gDecoratesStruct.materials, myIOnStruct, 1);
						array_delete(gDecoratesSpritesStruct.sprites, myIOnStruct, 1);
						_jsonTemp = json_stringify(gDecoratesStruct);
						
						FileWrite(WORKFILEPATH + FILEJSON_decorates, _jsonTemp);
						
						FileRemove(WORKFILEPATH + FILEPATH_decorates + myFilename);
						break;
					case ESandboxSceneElementsLayers.beds:
						array_delete(gBedsStruct.materials, myIOnStruct, 1);
						array_delete(gBedsSpritesStruct.sprites, myIOnStruct, 1);
						_jsonTemp = json_stringify(gBedsStruct);
						
						FileWrite(WORKFILEPATH + FILEJSON_beds, _jsonTemp);
						
						FileRemove(WORKFILEPATH + FILEPATH_beds + myFilename);
						break;
				}
				
				//_jsonTemp = json_stringify(gSceneStruct);
				//FileWrite(WORKFILEPATH + FILEJSON_scene, _jsonTemp);
				
				SaveCloudPack();
			}
		}
		
		// 修改其它 DragObj 的 materialId
		if(myIOnMasterPage != -1) {
			if(materialId == gSceneStruct.defaultBackground) {
				gSceneStruct.defaultBackground = -1;
			}
			for(var i = myIOnMasterPage; i < myIOnMasterPageLen - 1; i++) {
				if(mySandboxSceneElementsLayer == ESandboxSceneElementsLayers.backgrounds)
				if(gSceneStruct.defaultBackground != -1 && gSceneStruct.defaultBackground == masterPage.vecChildElements.Container[i].materialId) {
					gSceneStruct.defaultBackground--;
				}
				masterPage.vecChildElements.Container[i].materialId--;
			}
		}
		
		if(mySandboxSceneElementsLayer == ESandboxSceneElementsLayers.beds) {
			array_delete(gArrDragObjBedsCount, materialId, 1);
		}
		
		instance_destroy(id);
	}
}

