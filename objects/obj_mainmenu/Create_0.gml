DebugMes("working_directory = " + string(working_directory));
DebugMes("program_directory = " + string(program_directory));
DebugMes("temp_directory = " + string(temp_directory));

GuiElement_CreateButton_ext(128, 128, "新建场景包", 256, 64, function() {
	DebugMes("Create New ScenePackage");
	
	PackName = get_string("给新场景包取个名字吧~\n请使用英文名！不要输入中文！！！\n请使用英文名！不要输入中文！！！\n请使用英文名！不要输入中文！！！\n", "");
	if(PackName != "") {
		var _newpackfilename = WORKFILEPATH;
		
		_newpackfilename += PackName + PackFileExtension;
		var fwriteRes = FileWrite(_newpackfilename, "");
		
		DebugMes("FileWrite: " + string(fwriteRes));
		
		DebugMes("_newpackfilename: " + _newpackfilename);
		
		if(fwriteRes == 0) {
			FilePath_backgrounds = WORKFILEPATH + FilePath_backgrounds;
			FilePath_decorates = WORKFILEPATH + FilePath_decorates;
			FilePath_beds = WORKFILEPATH + FilePath_beds;
			
			room_goto(rm_Sandbox);
		} else {
			show_message("新建文件失败！" + string(fwriteRes));
		}
	}
});

GuiElement_CreateButton_ext(128, 228, "打开场景包", 256, 64, function() {
	var filename = get_open_filename_ext("云睡觉场景包(*"+ PackFileExtension +")|*" + PackFileExtension, "", program_directory, "打开场景包");
	if(filename != "") {
		PackName = GetNameFromFileName(filename, false);
		
		DebugMes("Open ScenePackage : " + filename + " | PackName : " + PackName);
		
		FilePath_backgrounds = WORKFILEPATH + FilePath_backgrounds;
		FilePath_decorates = WORKFILEPATH + FilePath_decorates;
		FilePath_beds = WORKFILEPATH + FilePath_beds;
		
		
		LoadCloudPack();
		
		room_goto(rm_Sandbox);
	} else {
		DebugMes("Open ScenePackage, but empty");
	}
});

GuiElement_CreateButton_ext(128, 328, "退出", 256, 64, function() {
	DebugMes("Exit");
	game_end();
});

