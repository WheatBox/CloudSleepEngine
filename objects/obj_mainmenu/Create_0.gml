GuiElement_CreateButton_ext(128, 128, "新建场景包", 256, 64, function() {
	DebugMes("Create New ScenePackage");
	
	room_goto(rm_Sandbox);
});

GuiElement_CreateButton_ext(128, 228, "打开场景包", 256, 64, function() {
	var file = get_open_filename_ext("云睡觉场景包(*.cloudpack)|*.cloudpack", "", program_directory, "打开场景包");
	if(file != "") {
		DebugMes("Open ScenePackage : " + file);
	} else {
		DebugMes("Open ScenePackage, but empty");
	}
});

GuiElement_CreateButton_ext(128, 328, "退出", 256, 64, function() {
	DebugMes("Exit");
});

