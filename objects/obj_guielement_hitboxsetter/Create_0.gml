materialMasterArr = [];
materialId = -1;

sprite = undefined;

xscale = 0;
yscale = 0;

// 我的当前正在设定中的碰撞箱
myhitLeft = 0;
myhitTop = 0;
myhitRight = 0;
myhitBottom = 0;


width = undefined;

mouseOnMe = false;


myImageMinimumWidthHeight = 512;
bottomEdgeHeight = 88;

left = 480;
top = 64;
right = left + myImageMinimumWidthHeight;
bottom = top + myImageMinimumWidthHeight;

spriteLeft = left;
spriteTop = top;
spriteRight = right;
spriteBottom = bottom;

// 可拖动的角标的大小（的一半）
draggerRadius = 8;

// 0 左上，1 右上，2 左下，3 右下，-1 无
draggerIdMouseOn = -1;

mouseIsDragging = false;


MyAutoSet = function() {
	var bboxmodeWas = sprite_get_bbox_mode(sprite);
	sprite_set_bbox_mode(sprite, bboxmode_automatic);
	
	myhitLeft = sprite_get_bbox_left(sprite);
	myhitTop = sprite_get_bbox_top(sprite);
	myhitRight = sprite_get_bbox_right(sprite);
	myhitBottom = sprite_get_bbox_bottom(sprite);
	
	sprite_set_bbox_mode(sprite, bboxmodeWas);
}
MySave = function() {
	if(materialId >= 0 && materialId < array_length(materialMasterArr)) {
		materialMasterArr[materialId].hitbox[0] = myhitLeft;
		materialMasterArr[materialId].hitbox[1] = myhitTop;
		materialMasterArr[materialId].hitbox[2] = myhitRight;
		materialMasterArr[materialId].hitbox[3] = myhitBottom;
	}
}


vecMyGuiElements = new vector();

var _strTemp = "";

_strTemp = "自动设定";
vecMyGuiElements.push_back(GuiElement_CreateButton(left + 32 + string_width(_strTemp) / 2, bottom + bottomEdgeHeight / 2, _strTemp, function() { MyAutoSet(); MySynchHitboxTextbox(); }));


// hitLeft/Top/Right/Bottom 文本框
var _hitboxTextboxWidth = string_width("000000");
var _hitboxTextboxHeight = string_height("0");

// hitLeft
vecMyGuiElements.push_back(textbox_create(left + 128, bottom + bottomEdgeHeight / 2 - _hitboxTextboxHeight / 2, _hitboxTextboxWidth, _hitboxTextboxHeight, string(myhitLeft), "left", 24, fontRegular, function() {}));
textbox_set_font(vecMyGuiElements.back(), fontRegular, c_white, _hitboxTextboxHeight, 0);
hitLeftTextboxIns = vecMyGuiElements.back();

// hitTop
vecMyGuiElements.push_back(textbox_create(left + 128 + _hitboxTextboxWidth + 16, bottom + 8, _hitboxTextboxWidth, _hitboxTextboxHeight, string(myhitTop), "top", 24, fontRegular, function() {}));
textbox_set_font(vecMyGuiElements.back(), fontRegular, c_white, _hitboxTextboxHeight, 0);
hitTopTextboxIns = vecMyGuiElements.back();

// hitRight
vecMyGuiElements.push_back(textbox_create(left + 128 + (_hitboxTextboxWidth + 16) * 2, bottom + bottomEdgeHeight / 2 - _hitboxTextboxHeight / 2, _hitboxTextboxWidth, _hitboxTextboxHeight, string(myhitRight), "right", 24, fontRegular, function() {}));
textbox_set_font(vecMyGuiElements.back(), fontRegular, c_white, _hitboxTextboxHeight, 0);
hitRightTextboxIns = vecMyGuiElements.back();

// hitBottom
vecMyGuiElements.push_back(textbox_create(left + 128 + _hitboxTextboxWidth + 16, bottom + 8 + 16 + _hitboxTextboxHeight, _hitboxTextboxWidth, _hitboxTextboxHeight, string(myhitBottom), "bottom", 24, fontRegular, function() {}));
textbox_set_font(vecMyGuiElements.back(), fontRegular, c_white, _hitboxTextboxHeight, 0);
hitBottomTextboxIns = vecMyGuiElements.back();


_strTemp = "保存";
vecMyGuiElements.push_back(GuiElement_CreateButton(right - 32 - string_width(_strTemp) / 2, bottom + bottomEdgeHeight / 2, _strTemp, function() { MySave(); }));

for(var i = 0; i < vecMyGuiElements.size(); i++) {
	if(InstanceExists(vecMyGuiElements.Container[i])) {
		vecMyGuiElements.Container[i].depth = depth - 1;
	}
}


MySynchHitboxTextbox = function() {
	if(InstanceExists(hitLeftTextboxIns)) {
		hitLeftTextboxIns.curt.tx = (string(myhitLeft));
	}
	if(InstanceExists(hitTopTextboxIns)) {
		hitTopTextboxIns.curt.tx = (string(myhitTop));
	}
	if(InstanceExists(hitRightTextboxIns)) {
		hitRightTextboxIns.curt.tx = (string(myhitRight));
	}
	if(InstanceExists(hitBottomTextboxIns)) {
		hitBottomTextboxIns.curt.tx = (string(myhitBottom));
	}
}



inited = false;
alarm_set(0, 1);
