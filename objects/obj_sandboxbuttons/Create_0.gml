{ // 切换网格 按钮
	var _labelGridAlignment = "切换网格";
	_labelGridAlignmentWidth = string_width(_labelGridAlignment);
	var _labelGridAlignmentHeight = string_height(_labelGridAlignment);
	buttonGridAlignmentIns = GuiElement_CreateButton(
		GuiWidth() - _labelGridAlignmentWidth / 2,
		_labelGridAlignmentHeight / 2,
		_labelGridAlignment,
		function() {
			gSceneElementsGridAlignmentEnable = !gSceneElementsGridAlignmentEnable;
		}
	);
}
{ // 显示碰撞 按钮
	var _labelGridShowHitbox = "显示碰撞";
	_labelGridShowHitboxWidth = string_width(_labelGridShowHitbox);
	var _labelGridShowHitboxHeight = string_height(_labelGridShowHitbox);
	buttonGridShowHitboxIns = GuiElement_CreateButton(
		GuiWidth() - _labelGridShowHitboxWidth / 2,
		_labelGridShowHitboxHeight / 2,
		_labelGridShowHitbox,
		function() {
			gGridShowHitBoxEnable = !gGridShowHitBoxEnable;
		}
	);
}
{ // SandboxMode 按钮
	var _labelSandboxMode = "普通模式";
	_labelSandboxModeWidth = string_width(_labelSandboxMode);
	var _labelGridShowHitboxHeight = string_height(_labelSandboxMode);
	buttonSandboxModeIns = GuiElement_CreateButton_ext(
		GuiWidth() - _labelSandboxModeWidth / 2,
		_labelGridShowHitboxHeight / 2,
		_labelSandboxMode, , , ,
		function(args) {
			switch(gSandboxMode) {
				case ESandboxMode.Normal:
					gSandboxMode = ESandboxMode.Pencil;
					args[0].labelText = "铅笔模式";
					break;
				case ESandboxMode.Pencil:
					gSandboxMode = ESandboxMode.Eraser;
					args[0].labelText = "橡皮模式";
					break;
				case ESandboxMode.Eraser:
					gSandboxMode = ESandboxMode.Normal;
					args[0].labelText = "普通模式";
					break;
			}
		}
	);
	buttonSandboxModeIns.MyPressedFunctionArgs = [buttonSandboxModeIns];
}

{
	_slidingRodOutFocusLayerAlphaWidth = 228;
	slidingRodOutFocusLayerAlphaIns = GuiElement_CreateSlidingRod(
		GuiWidth() - _slidingRodOutFocusLayerAlphaWidth
		, 32
		, "焦点外图层透明度"
		, _slidingRodOutFocusLayerAlphaWidth
		, make_wheat_ptr(EWheatPtrType.Global, 0, "gOutFocusLayerAlpha")
		, 0, 1
		, function(n) { n *= 10; return round(n) / 10; }
	);
}
{
	_slidingRodGridAlphaWidth = 228;
	slidingRodGridAlphaIns = GuiElement_CreateSlidingRod(
		GuiWidth() - _slidingRodGridAlphaWidth
		, 32
		, "网格线透明度"
		, _slidingRodGridAlphaWidth
		, make_wheat_ptr(EWheatPtrType.Global, 0, "gGridAlpha")
		, 0, 1
		, function(n) { n *= 100; return round(n) / 100; }
	);
}

MySynchMyGuiElementsPosition = function() {
	static _SynchSlidingRodXScreenLeftFunc = function(_insTemp, _xToLeftMultiply = 1, _xToLeftMultiplyMax = 1) {
		if(InstanceExists(_insTemp)) {
			var _xTemp = _insTemp.x;
			var _yTemp = _insTemp.y;
			var _wTemp = _insTemp.width + 1;
			var _hTemp = _insTemp.height;
			if(gMouseDraggingSlidingRodIns == _insTemp || GUI_MouseGuiOnMe(0 - 48, _yTemp, _xTemp + _wTemp + 48 + _wTemp * (_xToLeftMultiplyMax - _xToLeftMultiply), _yTemp + _hTemp) && GetPositionXOnGUI(mouse_x) > -48) {
				_xTemp = lerp(_xTemp, 0 + _wTemp * (_xToLeftMultiply - 1), 0.2);
			} else {
				_xTemp = lerp(_xTemp, 0 + 32 - _wTemp * (_xToLeftMultiplyMax - _xToLeftMultiply + 1), 0.2);
			}
			_insTemp.x = _xTemp;
		}
	}
	static _SynchSlidingRodXScreenRightFunc = function(_insTemp, _xToRightMultiply = 1, _xToRightMultiplyMax = 1) {
		if(InstanceExists(_insTemp)) {
			var _guiW = GuiWidth();
			
			var _xTemp = _insTemp.x;
			var _yTemp = _insTemp.y;
			var _wTemp = _insTemp.width + 1;
			var _hTemp = _insTemp.height;
			if(gMouseDraggingSlidingRodIns == _insTemp || GUI_MouseGuiOnMe(_xTemp - 48 - _wTemp * (_xToRightMultiplyMax - _xToRightMultiply), _yTemp, _guiW + 48, _yTemp + _hTemp) && GetPositionXOnGUI(mouse_x) < _guiW + 48) {
				_xTemp = lerp(_xTemp, _guiW - _wTemp * _xToRightMultiply, 0.2);
			} else {
				_xTemp = lerp(_xTemp, _guiW - 32 + _wTemp * (_xToRightMultiplyMax - _xToRightMultiply), 0.2);
			}
			_insTemp.x = _xTemp;
		}
	}
	
	_SynchSlidingRodXScreenRightFunc(slidingRodOutFocusLayerAlphaIns, 1, 2);
	_SynchSlidingRodXScreenRightFunc(slidingRodGridAlphaIns, 2, 2);
}
MySynchMyGuiElementsPosition();

