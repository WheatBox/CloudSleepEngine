/// 注意！！！elementIns.y 在此处变为增量y，如果想要紧挨着最后一个元素添加，请直接设0！！！
function GuiElement_PageAddElement(pageIns, elementIns, elementHeight = undefined) {
	with(pageIns) {
		var ins = elementIns;
		if(instance_exists(ins)) {
			ins.x += x;
			ins.y += y;
			
			for(var i = 0; i < vecChildElementsHeight.size(); i++) {
				ins.y += vecChildElementsHeight.Container[i];
			}
			
			vecChildElements.push_back(ins);
			
			if(elementHeight == undefined) {
				if(ins[$ "height"] != undefined) {
					vecChildElementsHeight.push_back(ins.height);
				} else {
					vecChildElementsHeight.push_back(64);
				}
			} else {
				vecChildElementsHeight.push_back(elementHeight);
			}
			
			instance_deactivate_object(ins);
		}
	}
}


function GuiElement_PageGetIsWorking(ins) {
	if(instance_exists(ins)) {
		return ins.working;
	}
	return false;
}

function GuiElement_PageStartWork(ins) {
	if(instance_exists(ins)) {
		ins.MyStartWork();
	}
}

function GuiElement_PageStopWork(ins) {
	if(instance_exists(ins)) {
		ins.MyStopWork();
	}
}

function GuiElement_PageStartWorkAll(_vector) {
	for(var i = 0; i < _vector.size(); i++) {
		GuiElement_PageStartWork(_vector.Container[i]);
	}
}

function GuiElement_PageStopWorkAll(_vector) {
	for(var i = 0; i < _vector.size(); i++) {
		GuiElement_PageStopWork(_vector.Container[i]);
	}
}

