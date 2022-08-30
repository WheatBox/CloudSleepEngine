function GuiElement_CreateButton(_xGui, _yGui, _label, _pressedFunc) {
	return GuiElement_CreateButton_ext(_xGui, _yGui, _label, , , _pressedFunc);
}

function GuiElement_CreateButton_ext(_xGui, _yGui, _label, _width = undefined, _height = undefined, _pressedFunc) {
	var ins = instance_create_depth(_xGui, _yGui,
		GUIDepth, obj_GuiElement_Button);
	ins.labelText = _label;
	ins.width = _width;
	ins.height = _height;
	ins.MyPressedFunction = _pressedFunc;
	
	return ins;
}

function GuiElement_CreatePage(_xGui, _yGui, _label, _width = undefined, _height = undefined) {
	var ins = instance_create_depth(_xGui, _yGui,
		GUIPageDepth, obj_GuiElement_Page);
	ins.labelText = _label;
	if(_width != undefined) {
		ins.width = _width;
	}
	if(_height != undefined) {
		ins.height = _height
	} else {
		ins.height = display_get_gui_height() - _yGui;
	}
	
	return ins;
}

