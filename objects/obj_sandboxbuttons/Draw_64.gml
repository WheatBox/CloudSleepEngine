var _guih = GuiHeight();
var _strTemp = "";
switch(gSandboxMode) {
	case ESandboxMode.Normal:
		_strTemp = "鼠标左键 拖动场景元素或移动视角，鼠标中键 移动视角";
		break;
	case ESandboxMode.Pencil:
		_strTemp = "鼠标左键 绘制，鼠标中键 移动视角，鼠标右键 擦除（仅擦除与当前笔刷相同的场景元素）";
		break;
	case ESandboxMode.Eraser:
		_strTemp = "鼠标左键 擦除（擦除当前选中图层中的场景元素）";
		break;
}

var _xTemp = 400;
var _scale = 0.8;

draw_set_color(c_black);
draw_set_alpha(GUIDefaultAlpha);
GUI_DrawRectangle(_xTemp, _guih - 28 * _scale, _xTemp + string_width(_strTemp) * _scale, _guih, false);

draw_set_color(c_white);
draw_set_alpha(0.7);
GUI_DrawTextTransformed(_xTemp, _guih - 28 * _scale, _strTemp, _scale, _scale, 0, false);

draw_set_alpha(1.0);