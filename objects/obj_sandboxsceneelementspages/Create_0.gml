depth = GUIPageDepth + 100;

y += 16;

buttons = new vector();
pages = new vector();

sandboxSceneElementsLayerNeedRecheck = false;

btWidth = 128;
btHeight = 32;
pageWidth = 256;
pageX = x + btWidth + 1;

btOffsetX = btWidth / 2;
btOffsetY = btHeight + 1;

buttons.push_back(GuiElement_CreateButton_ext(x + btOffsetX, y + btOffsetY * 0, "保存场景包", btWidth, btHeight, function() { SaveCloudPack(); }));
buttons.push_back(noone);
buttons.push_back(GuiElement_CreateButton_ext(x + btOffsetX, y + btOffsetY * 2, "玩家设置", btWidth, btHeight, function() { sandboxSceneElementsLayerNeedRecheck = true; if(GuiElement_PageGetIsWorking(pages.Container[
	0])) { GuiElement_PageStopWorkAll(pages); } else { GuiElement_PageStopWorkAll(pages); GuiElement_PageStartWork(pages.Container[
	0]); } }));
buttons.push_back(GuiElement_CreateButton_ext(x + btOffsetX, y + btOffsetY * 3, "背景", btWidth, btHeight, function() { sandboxSceneElementsLayerNeedRecheck = true; if(GuiElement_PageGetIsWorking(pages.Container[
	1])) { GuiElement_PageStopWorkAll(pages); } else { GuiElement_PageStopWorkAll(pages); GuiElement_PageStartWork(pages.Container[
	1]); } }));
buttons.push_back(GuiElement_CreateButton_ext(x + btOffsetX, y + btOffsetY * 4, "不可互动物体", btWidth, btHeight, function() { sandboxSceneElementsLayerNeedRecheck = true; if(GuiElement_PageGetIsWorking(pages.Container[
	2])) { GuiElement_PageStopWorkAll(pages); } else { GuiElement_PageStopWorkAll(pages); GuiElement_PageStartWork(pages.Container[
	2]); } }));
buttons.push_back(GuiElement_CreateButton_ext(x + btOffsetX, y + btOffsetY * 5, "\"床\"?", btWidth, btHeight, function() { sandboxSceneElementsLayerNeedRecheck = true; if(GuiElement_PageGetIsWorking(pages.Container[
	3])) { GuiElement_PageStopWorkAll(pages); } else { GuiElement_PageStopWorkAll(pages); GuiElement_PageStartWork(pages.Container[
	3]); } }));

pages.push_back(GuiElement_CreatePage(pageX, y - btHeight / 2, "玩家设置", pageWidth));
pages.push_back(GuiElement_CreatePage(pageX, y - btHeight / 2, "背景", pageWidth));
pages.push_back(GuiElement_CreatePage(pageX, y - btHeight / 2, "不可互动物体", pageWidth));
pages.push_back(GuiElement_CreatePage(pageX, y - btHeight / 2, "\"床\"?", pageWidth));

// myWidth = btWidth + pageWidth + 32;
myWidth = btWidth;
myHeight = display_get_gui_height() - y;


/* 添加组件到各个 页面 里 */
GuiElement_PageAddElement(pages.Container[1], GuiElement_CreateImportBackgroundButton(pageWidth / 2, 0, "导入素材", pageWidth - 32, 36));


alarm_set(0, 1);

MyRefreshPage = function() {
	var workingI = -1;
	for(var i = 0; i < pages.size(); i++) {
		
		// 获取当前打开中的 page
		if(GuiElement_PageGetIsWorking(pages.Container[i])) {
			workingI = i;
			break;
		}
	}
	
	if(workingI == -1 || i == pages.size()) {
		return;
	}
	
	MyInitPage(workingI);
	// GuiElement_PageAlign(pages.Container[workingI]);
}

MyInitPage = function(pageI) {
	var workingI = pageI;
	switch(workingI) {
		case 1:
			var arrLen = array_length(gBackgroundsSpritesStruct.sprites);
			GuiElement_PageClearIns(pages.Container[workingI], 1, -1);
			for(var i = 0; i < arrLen; i++) {
				GuiElement_PageAddElement(pages.Container[workingI], GuiElement_CreateDragObj(pageWidth / 2, 8, i, gBackgroundsSpritesStruct.sprites[i], gBackgroundsStruct.filename[i], ESandboxSceneElementsLayers.backgrounds, pages.Container[workingI]));
			}
			GuiElement_PageStopWork(pages.Container[workingI]);
			GuiElement_PageStartWork(pages.Container[workingI]);
			break;
	}
}

MyInitPageAll = function() {
	MyInitPage(1);
}


/* 这一段代码用以调试功能 */

GuiElement_PageAddElement(pages.Container[2], GuiElement_CreateButton(pageWidth / 2, 0, "测试按钮", function() { show_message("我是一个测试按钮"); }));
GuiElement_PageAddElement(pages.Container[2], GuiElement_CreateButton(pageWidth / 2, 0, "测试按钮2", function() { show_message("我是另一个测试按钮"); }));
GuiElement_PageAddElement(pages.Container[2], GuiElement_CreateButton(pageWidth / 2, 0, "测试按钮3", function() { show_message("我是第三个测试按钮"); }));
GuiElement_PageAddElement(pages.Container[2], GuiElement_CreateButton(pageWidth / 2 - 48, 0, "往左偏移些的按钮", function() { show_message("我是歪了的测试按钮"); }));
GuiElement_PageAddElement(pages.Container[2], GuiElement_CreateButton_ext(pageWidth / 2, 0, "我爱你", 160, 56, function() { show_message("爱你！"); }));
GuiElement_PageAddElement(pages.Container[2], GuiElement_CreateButton(pageWidth / 2, 0, "测试按钮4", function() { show_message("我是第4444个测试按钮"); }));
GuiElement_PageAddElement(pages.Container[2], GuiElement_CreateButton(pageWidth / 2, 16, "隔得远一点的按钮", function() { show_message("捏黑~"); }));
GuiElement_PageAddElement(pages.Container[2], GuiElement_CreateButton(pageWidth / 2, 0, "紧贴着隔得远一点的按钮的按钮", function() { show_message("捏嘿嘿嘿嘿~"); }));
/*
GuiElement_PageAddElement(pages.Container[2], GuiElement_CreateButton_ext(pageWidth / 2, 0, "按钮", 96, 200, function() { show_message("我是一个测试按钮"); }));
GuiElement_PageAddElement(pages.Container[2], GuiElement_CreateButton(pageWidth / 2, 0, "我也是按钮", function() { show_message("我是另一个测试按钮"); }));
*/
var tb = textbox_create(160, 36, 200, 28, "", "测试测试", 32, fontRegular, function() {});
tb.depth = GUIDepth;
textbox_set_font(tb, fontRegular, c_white, 28, 0);
var tb2 = textbox_create(160, 36, 200, 28, "", "测试测试2222", 32, fontRegular, function() {});
tb2.depth = GUIDepth;
textbox_set_font(tb2, fontRegular, c_white, 28, 0);
textbox_set_position(tb2, 0, 36, true);
GuiElement_PageAddElement(pages.Container[3], tb, 36);
GuiElement_PageAddElement(pages.Container[3], tb2, 36);
GuiElement_PageAddElement(pages.Container[3], GuiElement_CreateButton(pageWidth / 2, 0, "我写了啥？", function() { show_message(textbox_return(pages.Container[3].vecChildElements.Container[0]) + " And " + textbox_return(pages.Container[3].vecChildElements.Container[1])); }));

