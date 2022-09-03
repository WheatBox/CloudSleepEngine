// 网格的格子数量
// 实际大小（单位：像素） = ((right - left) * cellSize) * ((bottom - top) * cellSize)
left = 0;
top = 0;
right = 100;
bottom = 80;

lineWidth = 2;

cellSize = SCENE_CellSize;

// 可拖动的角标的大小（的一半）
draggerRadius = 12;

// 0 左上，1 右上，2 左下，3 右下，-1 无
draggerIdMouseOn = -1;

mouseIsDragging = false;

