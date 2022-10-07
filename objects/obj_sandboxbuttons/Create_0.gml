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

