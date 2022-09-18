if(GUI_MouseGuiOnMe(left, top, right, bottom + bottomEdgeHeight)) {
	mouseOnMe = true;
	gMouseOnGUI = true;
} else if(draggerIdMouseOn = -1) {
	mouseOnMe = false;
	
	if(MouseLeftPressed() || MouseRightPressed()) {
		instance_destroy(id);
	}
}


var leftPixel = spriteLeft + myhitLeft * xscale;
var topPixel = spriteTop + myhitTop * yscale;
var rightPixel = spriteLeft + myhitRight * xscale;
var bottomPixel = spriteTop + myhitBottom * yscale;

if(/*GUI_MouseGuiOnMe(spriteLeft, spriteTop, spriteRight, spriteBottom) && */mouseIsDragging == false) {
	if(GUI_MouseGuiOnMe_Radius(leftPixel, topPixel, draggerRadius)) {
		draggerIdMouseOn = 0;
	} else
	if(GUI_MouseGuiOnMe_Radius(rightPixel, topPixel, draggerRadius)) {
		draggerIdMouseOn = 1;
	} else
	if(GUI_MouseGuiOnMe_Radius(leftPixel, bottomPixel, draggerRadius)) {
		draggerIdMouseOn = 2;
	} else
	if(GUI_MouseGuiOnMe_Radius(rightPixel, bottomPixel, draggerRadius)) {
		draggerIdMouseOn = 3;
	} else {
		draggerIdMouseOn = -1;
	}
}


if(inited) {
	var myhitLeftStr = string_digits(textbox_return(hitLeftTextboxIns));
	var myhitTopStr = string_digits(textbox_return(hitTopTextboxIns));
	var myhitRightStr = string_digits(textbox_return(hitRightTextboxIns));
	var myhitBottomStr = string_digits(textbox_return(hitBottomTextboxIns));

	myhitLeft = (string_length(myhitLeftStr) > 0) ? real(myhitLeftStr) : 0;
	myhitTop = (string_length(myhitTopStr) > 0) ? real(myhitTopStr) : 0;
	myhitRight = (string_length(myhitRightStr) > 0) ? real(myhitRightStr) : 0;
	myhitBottom = (string_length(myhitBottomStr) > 0) ? real(myhitBottomStr) : 0;

	// if(GUI_MouseGuiOnMe(spriteLeft, spriteTop, spriteRight, spriteBottom)) {
	if(1) {
		if(draggerIdMouseOn != -1) {
			gMouseOnGUI = true;
			if(MouseLeftHold()) {
				mouseIsDragging = true;
		
				gMouseOnGUI = true;
		
				var mx = round((GetPositionXOnGUI(mouse_x) - spriteLeft) / xscale);
				var my = round((GetPositionYOnGUI(mouse_y) - spriteTop) / yscale);
		
				switch(draggerIdMouseOn) {
					case 0:
						myhitLeft = round(mx);
						myhitTop = round(my);
				
						myhitLeft = clamp(myhitLeft, 0, myhitRight);
						myhitTop = clamp(myhitTop, 0, myhitBottom);
				
						break;
					case 1:
						myhitRight = round(mx);
						myhitTop = round(my);
				
						myhitRight = clamp(myhitRight, myhitLeft, sprite_get_width(sprite) - 1);
						myhitTop = clamp(myhitTop, 0, myhitBottom);
				
						break;
					case 2:
						myhitLeft = round(mx);
						myhitBottom = round(my);
				
						myhitLeft = clamp(myhitLeft, 0, myhitRight);
						myhitBottom = clamp(myhitBottom, myhitTop, sprite_get_height(sprite) - 1);
				
						break;
					case 3:
						myhitRight = round(mx);
						myhitBottom = round(my);
				
						myhitRight = clamp(myhitRight, myhitLeft, sprite_get_width(sprite) - 1);
						myhitBottom = clamp(myhitBottom, myhitTop, sprite_get_height(sprite) - 1);
				
						break;
				}
			} else {
				mouseIsDragging = false;
			}
		}
	}
	
	if((hitLeftTextboxIns.curt.fo || hitTopTextboxIns.curt.fo || hitRightTextboxIns.curt.fo || hitBottomTextboxIns.curt.fo) == false) {
		MySynchHitboxTextbox();
	}
}

