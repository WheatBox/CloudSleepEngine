{
	var _labelGridAlignment = "切换网格";
	var _labelGridAlignmentWidth = string_width(_labelGridAlignment);
	var _labelGridAlignmentHeight = string_height(_labelGridAlignment);
	GuiElement_CreateButton(
		GuiWidth() - _labelGridAlignmentWidth / 2,
		_labelGridAlignmentHeight / 2,
		_labelGridAlignment,
		function() {
			gSceneElementsGridAlignmentEnable = !gSceneElementsGridAlignmentEnable;
		}
	);
}
