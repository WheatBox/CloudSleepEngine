if(InstanceExists(buttonGridAlignmentIns))
	buttonGridAlignmentIns.x = GuiWidth() - buttonGridAlignmentIns.width / 2;
if(InstanceExists(buttonGridShowHitboxIns))
	buttonGridShowHitboxIns.x = buttonGridAlignmentIns.x - buttonGridAlignmentIns.width / 2
		- buttonGridShowHitboxIns.width / 2 - 1;

MySynchMyGuiElementsPosition();
