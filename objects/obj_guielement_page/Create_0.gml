vecChildElements = new vector();
vecChildElementsHeight = new vector();

labelText = "";

width = 256;
height = 0; // height 的真正初始化需要在 GuiElement_CreatePage() 找到

visible = false;
working = false;

MyStartWork = function() {
	if(working == false) {
		working = true;
		
		DebugMes(labelText + " Page On");
		
		for(var i = 0; i < vecChildElements.size(); i++) {
			instance_activate_object(vecChildElements.Container[i]);
		}
	}
}

MyStopWork = function() {
	if(working == true) {
		working = false;
		
		DebugMes(labelText + " Page Off");
		
		for(var i = 0; i < vecChildElements.size(); i++) {
			instance_deactivate_object(vecChildElements.Container[i]);
		}
	}
}

