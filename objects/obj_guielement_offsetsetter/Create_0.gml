labelText = "";

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
vecMyGuiElements.push_back(GuiElement_CreateButton(left + 32 + string_width(_strTemp) / 2, bottom + bottomEdgeHeight / 2, _strTemp, function() { MyAutoSet(); }));

_strTemp = "保存";
vecMyGuiElements.push_back(GuiElement_CreateButton(right - 32 - string_width(_strTemp) / 2, bottom + bottomEdgeHeight / 2, _strTemp, function() { MySave(); }));

for(var i = 0; i < vecMyGuiElements.size(); i++) {
	if(InstanceExists(vecMyGuiElements.Container[i])) {
		vecMyGuiElements.Container[i].depth = depth - 1;
	}
}



alarm_set(0, 1);
