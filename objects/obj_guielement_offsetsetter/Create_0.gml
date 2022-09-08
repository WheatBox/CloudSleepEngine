materialMasterArr = [];
materialId = -1;

sprite = undefined;

xscale = 0;
yscale = 0;

// 我的当前正在设定中的中心点
myoffx = 0;
myoffy = 0;


width = undefined;

mouseOnMe = false;


myImageMinimumWidthHeight = 512;
bottomEdgeHeight = 36;

left = 480;
top = 64;
right = left + myImageMinimumWidthHeight;
bottom = top + myImageMinimumWidthHeight;

spriteLeft = left;
spriteTop = top;
spriteRight = right;
spriteBottom = bottom;


MyAutoSet = function() {
	myoffx = round(sprite_get_width(sprite) / 2);
	myoffy = round(sprite_get_height(sprite) / 2);
}
MySave = function() {
	if(materialId >= 0 && materialId < array_length(materialMasterArr)) {
		materialMasterArr[materialId].offset[0] = myoffx;
		materialMasterArr[materialId].offset[1] = myoffy;
	}
}


vecMyGuiElements = new vector();

var _strTemp = "";

_strTemp = "自动设定";
vecMyGuiElements.push_back(GuiElement_CreateButton(left + 32 + string_width(_strTemp) / 2, bottom + bottomEdgeHeight / 2, _strTemp, function() { MyAutoSet(); MyAsyncXYTextbox(); }));

// x和y文本框
var _xyTextboxWidth = string_width("000000");
var _xyTextboxHeight = string_height("0");

vecMyGuiElements.push_back(textbox_create(left + 128, bottom + 4, _xyTextboxWidth, _xyTextboxHeight, string(myoffx), "x", 24, fontRegular, function() {}));
textbox_set_font(vecMyGuiElements.back(), fontRegular, c_white, _xyTextboxHeight, 0);
xTextboxIns = vecMyGuiElements.back();

vecMyGuiElements.push_back(textbox_create(left + 128 + _xyTextboxWidth + 16, bottom + 4, _xyTextboxWidth, _xyTextboxHeight, string(myoffy), "y", 24, fontRegular, function() {}));
textbox_set_font(vecMyGuiElements.back(), fontRegular, c_white, _xyTextboxHeight, 0);
yTextboxIns = vecMyGuiElements.back();


_strTemp = "保存";
vecMyGuiElements.push_back(GuiElement_CreateButton(right - 32 - string_width(_strTemp) / 2, bottom + bottomEdgeHeight / 2, _strTemp, function() { MySave(); }));

for(var i = 0; i < vecMyGuiElements.size(); i++) {
	if(InstanceExists(vecMyGuiElements.Container[i])) {
		vecMyGuiElements.Container[i].depth = depth - 1;
	}
}


MyAsyncXYTextbox = function() {
	if(InstanceExists(xTextboxIns)) {
		xTextboxIns.curt.tx = (string(myoffx));
	}
	if(InstanceExists(yTextboxIns)) {
		yTextboxIns.curt.tx = (string(myoffy));
	}
}



inited = false;
alarm_set(0, 1);
