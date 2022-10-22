// SaveDrawSettings();
/*
draw_set_color(c_black);

if(gSceneElementsGridAlignmentEnable == false)
	draw_set_alpha(0.05);
else
	draw_set_alpha(0.2);

var leftPixel = gSceneStruct.left * cellSize;
var rightPixel = gSceneStruct.right * cellSize;
var topPixel = gSceneStruct.top * cellSize;
var bottomPixel = gSceneStruct.bottom * cellSize;

// 画横线
for(var iy = gSceneStruct.top; iy <= gSceneStruct.bottom; iy++) {
	draw_line_width(leftPixel, iy * cellSize, rightPixel, iy * cellSize, lineWidth);
}
// 画竖线
for(var ix = gSceneStruct.left; ix <= gSceneStruct.right; ix++) {
	draw_line_width(ix * cellSize, topPixel, ix * cellSize, bottomPixel, lineWidth);
}
*/
// LoadDrawSettings();

if(gGridShowHitBoxEnable) {
	if(mpGridHitboxDraw == -1) {
		//mpGridHitboxDraw = mp_grid_create(
		//	floor(CameraX() / cellSize) * cellSize
		//	, floor(CameraY() / cellSize) * cellSize
		//	, CameraWidth() / cellSize + 2
		//	, CameraHeight() / cellSize + 2
		//	, cellSize, cellSize
		//);
		mpGridHitboxDraw = mp_grid_create(
			gSceneStruct.left * cellSize
			, gSceneStruct.top * cellSize
			, gSceneStruct.right - gSceneStruct.left
			, gSceneStruct.bottom - gSceneStruct.top
			, cellSize, cellSize
		);
		
		with(obj_SceneElementDecorate) {
			try {
				mp_grid_add_rectangle(other.mpGridHitboxDraw
					, basex - offsetx + gDecoratesStruct.materials[materialId].hitbox[0]
					, basey - offsety + gDecoratesStruct.materials[materialId].hitbox[1]
					, basex - offsetx + gDecoratesStruct.materials[materialId].hitbox[2]
					, basey - offsety + gDecoratesStruct.materials[materialId].hitbox[3]
				);
			} catch(error) {
				
			}
		}
		with(obj_SceneElementBed) {
			try {
				mp_grid_add_rectangle(other.mpGridHitboxDraw
					, basex - offsetx + gBedsStruct.materials[materialId].hitbox[0]
					, basey - offsety + gBedsStruct.materials[materialId].hitbox[1]
					, basex - offsetx + gBedsStruct.materials[materialId].hitbox[2]
					, basey - offsety + gBedsStruct.materials[materialId].hitbox[3]
				);
			} catch(error) {
				
			}
		}
		
		surface_free(gridHitboxSurf); // 主动清除 surface，以此来让后续的 MyCheckAndCreateGridHitboxSurf() 能够执行
	}
} else {
	if(mpGridHitboxDraw != -1) {
		mp_grid_destroy(mpGridHitboxDraw);
		mpGridHitboxDraw = -1;
	}
}

MyCheckAndCreateGridSurf();
if(surface_exists(gridSurf)) {
	var leftPixel = gSceneStruct.left * cellSize;
	var rightPixel = gSceneStruct.right * cellSize;
	var topPixel = gSceneStruct.top * cellSize;
	var bottomPixel = gSceneStruct.bottom * cellSize;
	
	for(var iy = gSceneStruct.top; iy < gSceneStruct.bottom; iy += gridSurfHeight / cellSize) {
		for(var ix = gSceneStruct.left; ix < gSceneStruct.right; ix += gridSurfWidth / cellSize) {
			var _wAddTemp = 0;
			var _hAddTemp = 0;
			
			// 是否为横向上最后一个
			if(ix + gridSurfWidth / cellSize > gSceneStruct.right) {
				_wAddTemp = lineWidth / 2 + 1;
			}
			
			// 是否为纵向上最后一个
			if(iy + gridSurfHeight / cellSize > gSceneStruct.bottom) {
				_hAddTemp = lineWidth / 2 + 1;
			}
			
			if(gSceneElementsGridAlignmentEnable) {
				draw_surface_part_ext(gridSurf
					, 0, 0, (gSceneStruct.right - ix) * cellSize + _wAddTemp, (gSceneStruct.bottom - iy) * cellSize + _hAddTemp
					, ix * cellSize, iy * cellSize
					, 1, 1, c_white
					, gGridAlpha);
			}
		}
	}
}
