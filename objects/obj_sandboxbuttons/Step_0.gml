if(InstanceExists(buttonGridAlignmentIns))
	buttonGridAlignmentIns.x = GuiWidth() - buttonGridAlignmentIns.width / 2;
if(InstanceExists(buttonGridShowHitboxIns))
	buttonGridShowHitboxIns.x = buttonGridAlignmentIns.x - buttonGridAlignmentIns.width / 2
		- buttonGridShowHitboxIns.width / 2 - 8;
if(InstanceExists(buttonSandboxModeIns))
	buttonSandboxModeIns.x = buttonGridShowHitboxIns.x - buttonGridShowHitboxIns.width / 2
		- buttonSandboxModeIns.width / 2 - 8;

MySynchMyGuiElementsPosition();
