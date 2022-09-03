/// @desc 设置物体的大小
/// @param {real} destWidth 宽
/// @param {real} destHeight 高
/// @param {id} destID 物体id，默认为当前物体的id，也可设为其它物体的id
function SetSize(destWidth, destHeight, destID = id) {
	with(destID) {
		image_xscale = destWidth / (sprite_width * image_xscale);
		image_yscale = destHeight / (sprite_height * image_yscale);
	}
}

/// @desc 设置物体的大小，但是锁定宽高比
/// @param {real} destWidth 宽
/// @param {id} destID 物体id，默认为当前物体的id，也可设为其它物体的id
function SetSizeLockAspect_Width(destWidth, destID = id) {
	with(destID) {
		image_xscale = destWidth / (sprite_width * image_xscale);
		image_yscale = image_xscale;
	}
}

/// @desc 设置物体的大小，但是锁定宽高比
/// @param {real} destHeight 高
/// @param {id} destID 物体id，默认为当前物体的id，也可设为其它物体的id
function SetSizeLockAspect_Height(destHeight, destID = id) {
	with(destID) {
		image_yscale = destHeight / (sprite_height * image_yscale);
		image_xscale = image_yscale;
	}
}

