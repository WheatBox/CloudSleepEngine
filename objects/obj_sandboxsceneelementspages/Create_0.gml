depth = GUIPageDepth + 100;

buttons = new vector();
pages = new vector();

btWidth = 128;
btHeight = 32;
pageWidth = 256;

btOffsetX = btWidth / 2;
btOffsetY = btHeight + 1;

buttons.push_back(GuiElement_CreateButton_ext(x + btOffsetX, y + btOffsetY * 0, "玩家设置", btWidth, btHeight, function() { if(GuiElement_PageGetIsWorking(pages.Container[0])) { GuiElement_PageStopWorkAll(pages); } else { GuiElement_PageStopWorkAll(pages); GuiElement_PageStartWork(pages.Container[0]); } }));
buttons.push_back(GuiElement_CreateButton_ext(x + btOffsetX, y + btOffsetY * 1, "背景", btWidth, btHeight, function() { if(GuiElement_PageGetIsWorking(pages.Container[1])) { GuiElement_PageStopWorkAll(pages); } else { GuiElement_PageStopWorkAll(pages); GuiElement_PageStartWork(pages.Container[1]); } }));
buttons.push_back(GuiElement_CreateButton_ext(x + btOffsetX, y + btOffsetY * 2, "不可互动物体", btWidth, btHeight, function() { if(GuiElement_PageGetIsWorking(pages.Container[2])) { GuiElement_PageStopWorkAll(pages); } else { GuiElement_PageStopWorkAll(pages); GuiElement_PageStartWork(pages.Container[2]); } }));
buttons.push_back(GuiElement_CreateButton_ext(x + btOffsetX, y + btOffsetY * 3, "\"床\"?", btWidth, btHeight, function() { if(GuiElement_PageGetIsWorking(pages.Container[3])) { GuiElement_PageStopWorkAll(pages); } else { GuiElement_PageStopWorkAll(pages); GuiElement_PageStartWork(pages.Container[3]); } }));

pages.push_back(GuiElement_CreatePage(x + btWidth + 1, y - btHeight / 2, "玩家设置", pageWidth));
pages.push_back(GuiElement_CreatePage(x + btWidth + 1, y - btHeight / 2, "背景", pageWidth));
pages.push_back(GuiElement_CreatePage(x + btWidth + 1, y - btHeight / 2, "不可互动物体", pageWidth));
pages.push_back(GuiElement_CreatePage(x + btWidth + 1, y - btHeight / 2, "\"床\"?", pageWidth));

myWidth = btWidth + pageWidth + 32;
myHeight = display_get_gui_height() - y;


GuiElement_PageAddElement(pages.Container[1], GuiElement_CreateButton(128, 64, "测试按钮", function() { show_message("我是一个测试按钮"); }));
GuiElement_PageAddElement(pages.Container[1], GuiElement_CreateButton(80, 64, "测试按钮2", function() { show_message("我是另一个测试按钮"); }));
GuiElement_PageAddElement(pages.Container[1], GuiElement_CreateButton_ext(128, 64, "我爱你", 160, 56, function() { show_message("爱你！"); }));

GuiElement_PageAddElement(pages.Container[2], GuiElement_CreateButton_ext(128, 128, "按钮", 96, 200, function() { show_message("我是一个测试按钮"); }));
GuiElement_PageAddElement(pages.Container[2], GuiElement_CreateButton(128, 64, "我也是按钮", function() { show_message("我是另一个测试按钮"); }));

GuiElement_PageAddElement(pages.Container[3], textbox_create(160, 96, 200, 32, "", "测试测试", 32, fontRegular, function() {}), 32);
GuiElement_PageAddElement(pages.Container[3], GuiElement_CreateButton(128, 64, "测试按钮", function() { show_message(textbox_return(pages.Container[3].vecChildElements.Container[0])); }));

