extends Node2D

var player: Player
var pivot: Pivot
var playerPos: Vector2
var mousePos: Vector2
var startPoint: Vector2
var endPoint: Vector2
var startPoint2: Vector2
var endPoint2: Vector2
var HorizontalPos
var VerticalPos

func _draw() -> void:
	if  -(PI*0.25) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.25:
		draw_arc(playerPos, 40, -(PI*0.25), PI*0.25, 100, Color.BLACK, 4, false)
		draw_arc(playerPos, 40, -(PI*0.23), PI*0.23, 100, Color.WHITE, 2, false)
	elif -(PI*0.75) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.25):
		draw_arc(playerPos, 40, -(PI*0.75), -(PI*0.25), 100, Color.BLACK, 4, false)
		draw_arc(playerPos, 40, -(PI*0.73), -(PI*0.27), 100, Color.WHITE, 2, false)
	elif PI*0.25 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.75:
		if pivot.IsInSideView:
			if !player.is_on_floor():
				draw_arc(playerPos, 40, PI*0.25, PI*0.75, 100, Color.BLACK, 4, false)
				draw_arc(playerPos, 40, PI*0.27, PI*0.73, 100, Color.WHITE, 2, false)
		else:
			draw_arc(playerPos, 40, PI*0.25, PI*0.75, 100, Color.BLACK, 4, false)
			draw_arc(playerPos, 40, PI*0.27, PI*0.73, 100, Color.WHITE, 2, false)
	elif PI*0.75 < playerPos.angle_to_point(mousePos) or playerPos.angle_to_point(mousePos) -(PI*0.75):
		draw_arc(playerPos, 40, PI*0.75, PI, 100, Color.BLACK, 4, false)
		draw_arc(playerPos, 40, PI*0.77, PI, 100, Color.WHITE, 2, false)
		draw_arc(playerPos, 40, -PI, -(PI*0.75), 100, Color.BLACK, 4, false)
		draw_arc(playerPos, 40, -PI, -(PI*0.77), 100, Color.WHITE, 2, false)
	draw_line(startPoint2, endPoint2, Color.BLACK, 4, false)
	draw_line(startPoint, endPoint, Color.WHITE, 2, false)

func _process(delta: float) -> void:
	if pivot.PivotRot == 0.0 and pivot.IsInSideView:
		HorizontalPos = (player.global_transform.origin.x - pivot.global_transform.origin.x + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	elif pivot.PivotRot == -90.0 and pivot.IsInSideView:
		HorizontalPos = (player.global_transform.origin.z - pivot.global_transform.origin.z + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	elif pivot.PivotRot == -180.0 and pivot.IsInSideView:
		HorizontalPos = 640 - (player.global_transform.origin.x - pivot.global_transform.origin.x + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	elif pivot.PivotRot == 90.0 and pivot.IsInSideView:
		HorizontalPos = 640 - (player.global_transform.origin.z - pivot.global_transform.origin.z + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	elif pivot.PivotRot == 0.0 and !pivot.IsInSideView:
		HorizontalPos = (player.global_transform.origin.x - pivot.global_transform.origin.x + 10) * 32
		VerticalPos = (player.global_transform.origin.z - pivot.global_transform.origin.z + 5.625) * 32
	elif pivot.PivotRot == -90.0 and !pivot.IsInSideView:
		HorizontalPos = (player.global_transform.origin.z - pivot.global_transform.origin.z + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.x - pivot.global_transform.origin.x + 5.625) * 32
	elif pivot.PivotRot == -180.0 and !pivot.IsInSideView:
		HorizontalPos = 640 - (player.global_transform.origin.x - pivot.global_transform.origin.x + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.z - pivot.global_transform.origin.z + 5.625) * 32
	elif pivot.PivotRot == 90.0 and !pivot.IsInSideView:
		HorizontalPos = 640 - (player.global_transform.origin.z - pivot.global_transform.origin.z + 10) * 32
		VerticalPos = (player.global_transform.origin.x - pivot.global_transform.origin.x + 5.625) * 32
	
	playerPos = Vector2(HorizontalPos, VerticalPos)
	mousePos = get_viewport().get_mouse_position()
	var rad = playerPos.angle_to_point(mousePos)
	var angle = rad_to_deg(rad)
	startPoint = Vector2(playerPos.x + 25*cos(rad), playerPos.y + 25*sin(rad))
	endPoint = Vector2(playerPos.x + 55*cos(rad), playerPos.y + 55*sin(rad))
	startPoint2 = Vector2(playerPos.x + 24*cos(rad), playerPos.y + 24*sin(rad))
	endPoint2 = Vector2(playerPos.x + 56*cos(rad), playerPos.y + 56*sin(rad))
	
	queue_redraw()
