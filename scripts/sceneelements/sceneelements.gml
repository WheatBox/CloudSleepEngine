#macro SceneDepth -100

globalvar gSceneElementsGridAlignmentEnable;
gSceneElementsGridAlignmentEnable = true;

function SceneElement_CreateBackground(sprite) {
	var ins = instance_create_depth(mouse_x, mouse_y, SceneDepth + 1, obj_SceneElementBackground);
	ins.sprite_index = sprite;
	ins.isDragging = true;
	
	// 为何上面写 SceneDepth + 1 然后这里又 depth--;
	// 因为我也不知道为啥，反正不这么写而直接填 SceneDepth 就会导致晚创建的物体在早创建的物体的下面
	ins.depth--;
	
	return ins;
}
