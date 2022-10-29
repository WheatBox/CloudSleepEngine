/// @desc DebugMes
/// @arg {Any} arg
function DebugMes(arg, inScript = false) {
	str = string(arg);
	if(inScript) {
		show_debug_message(str);
	} else {
		show_debug_message(object_get_name(object_index) + "-" + string(id) + ": " + str);
	}
}

function CheckStructCanBeUse(_structVal) {
	if(is_struct(_structVal) == true
		&& _structVal != NULL
		&& _structVal != "null"
		&& _structVal != pointer_null
		&& _structVal != undefined
	) {
		return true;
	} else {
		return false;
	}
}

function InstanceExists(ins) {
	if(ins == undefined || ins == noone) {
		return false;
	}
	return instance_exists(ins);
}


// 虽然这两个函数的运算其实完全一样，但是还是稍微像这样区分着规范一下比较好
function GetPositionXGridStandardization(_x, gridCellSize = SCENE_CellSize) {
	return floor((_x + gridCellSize / 2) / gridCellSize) * gridCellSize;
}
function GetPositionYGridStandardization(_y, gridCellSize = SCENE_CellSize) {
	return GetPositionXGridStandardization(_y, gridCellSize);
}


function ArrayReverse(arr) {
	var len = array_length(arr);
	for(var i = 0; i < len / 2; i++) {
		var t = arr[i];
		arr[i] = arr[len - i - 1];
		arr[len - i - 1] = t;
	}
}


/// @desc 同步 depth
function SynchDepth(_y = y) {
	depth = - GetPositionYOnGUI(_y) + SceneDepthDynamicAdd;
}


/// @desc 生成GUID
/// @arg {bool} withBrace 是否带有首尾的大括号，默认 true
function GuidGenerate(withBrace = true) {
	var S4 = function() {
		var str = DECtoHEX((1 + irandom_range(0, 999999) / 1000000) * 0x10000 | 0);
		return string_copy(str, 1 + 1, string_length(str) - 1);
	}
	
	var res = S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4();
	
	if(withBrace) {
		return "{" + res + "}";
	}
	
	return res;
}



/// @desc 计算 scrollY
function ScrollYCalculate(scrollY, scrollYSpeed, _guiTop, _guiBottom, _pageHeight) {
	var top = _guiTop;
	var bottom = _guiBottom;
	
	scrollY = -scrollY;
	
	if(mouse_wheel_up()) {
		scrollY -= scrollYSpeed;
		if(top + scrollY < 0) {
			scrollY -= top + scrollY;
		}
	} else if(mouse_wheel_down()) {
		if(_pageHeight >= bottom) {
			scrollY += scrollYSpeed;
			if(bottom + scrollY > _pageHeight) {
				scrollY -= bottom + scrollY - _pageHeight;
			}
		}
	}
	
	scrollY = -scrollY;
	
	return scrollY;
}

globalvar gArrDragObjBedsCount;
gArrDragObjBedsCount = [];
// gArrDragObjBedsCount[materialId]：该床在场景中的数量

function DragObjBedsCountAdd(_materialId) {
	if(_materialId < 0) {
		return;
	}
	if(array_length(gArrDragObjBedsCount) <= _materialId) {
		gArrDragObjBedsCount[_materialId] = 0;
	}
	gArrDragObjBedsCount[_materialId]++;
}

function DragObjBedsCountSubtract(_materialId) {
	if(_materialId < 0) {
		return;
	}
	if(array_length(gArrDragObjBedsCount) <= _materialId) {
		return;
		// gArrDragObjBedsCount[_materialId] = 0;
	}
	gArrDragObjBedsCount[_materialId]--;
}

function DragObjBedsCountGet(_materialId) {
	if(_materialId < 0) {
		return 0;
	}
	if(array_length(gArrDragObjBedsCount) <= _materialId) {
		return 0;
	}
	return gArrDragObjBedsCount[_materialId];
}

globalvar __InstancesOptimizeFreezing;
__InstancesOptimizeFreezing = 5;

/// @desc 将该函数放在 obj_camera 中
function InstancesOptimize() {
	static _arrObjTemp = [
		obj_SceneElementSleeper,
		obj_SceneElementBackground,
		obj_SceneElementDecorate,
		obj_SceneElementBed,
	];
	static _arrObjTempLen = array_length(_arrObjTemp);
	
	if(__InstancesOptimizeFreezing > 0) {
		__InstancesOptimizeFreezing--;
		return;
	}
	
	var _temp = 0;// 64;
	
	var _camleft = CameraX() - _temp;
	var _camtop = CameraY() - _temp;
	var _camright = _camleft + CameraWidth() + _temp;
	var _cambottom = _camtop + CameraHeight() + _temp;
	
	for(var i = 0; i < _arrObjTempLen; i++) {
		instance_activate_object(_arrObjTemp[i]);
		
		with(_arrObjTemp[i]) {
			if(rectangle_in_rectangle(
				_camleft, _camtop, _camright, _cambottom,
				bbox_left, bbox_top, bbox_right, bbox_bottom
			) == false) {
				instance_deactivate_object(id);
			}
		}
	}
}

function SceneElementsActivate() {
	static _arrObjTemp = [
		obj_SceneElementSleeper,
		obj_SceneElementBackground,
		obj_SceneElementDecorate,
		obj_SceneElementBed,
	];
	static _arrObjTempLen = array_length(_arrObjTemp);
	for(var i = 0; i < _arrObjTempLen; i++) {
		instance_activate_object(_arrObjTemp[i]);
	}
}
