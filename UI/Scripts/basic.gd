extends Node2D

var player: Player
var pivot: Pivot
var playerPos: Vector2
var mousePos: Vector2
var startPoint: Vector2
var endPoint: Vector2
var HorizontalPos: float
var VerticalPos: float

func _draw() -> void:
	if pivot.CurrentView == "Side":
		if  -(PI*0.25) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.25:
			draw_arc(playerPos, 40, -(PI*0.25), PI*0.25, 100, Color.PURPLE, 2, false)
		elif -(PI*0.75) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.25):
			draw_arc(playerPos, 40, -(PI*0.75), -(PI*0.25), 100, Color.PURPLE, 2, false)
		elif PI*0.25 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.75:
			if !player.is_on_floor() or player.CurrentState == "Crouch":
				draw_arc(playerPos, 40, PI*0.25, PI*0.75, 100, Color.PURPLE, 2, false)
		elif PI*0.75 < playerPos.angle_to_point(mousePos) or playerPos.angle_to_point(mousePos) < -(PI*0.75):
			draw_arc(playerPos, 40, PI*0.75, PI, 100, Color.PURPLE, 2, false)
			draw_arc(playerPos, 40, -PI, -(PI*0.75), 100, Color.PURPLE, 2, false)
	else:
		if  PI*0.625 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.875:
			draw_arc(playerPos, 40, PI*0.625, PI*0.875, 100, Color.PURPLE, 2, false)
		elif  PI*0.375 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.625:
			draw_arc(playerPos, 40, PI*0.375, PI*0.625, 100, Color.PURPLE, 2, false)
		elif  PI*0.125 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.375:
			draw_arc(playerPos, 40, PI*0.125, PI*0.375, 100, Color.PURPLE, 2, false)
		elif  -(PI*0.125) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.125:
			draw_arc(playerPos, 40, -(PI*0.125), PI*0.125, 100, Color.PURPLE, 2, false)
		elif -(PI*0.375) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.125):
			draw_arc(playerPos, 40, -(PI*0.375), -(PI*0.125), 100, Color.PURPLE, 2, false)
		elif -(PI*0.625) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.375):
			draw_arc(playerPos, 40, -(PI*0.625), -(PI*0.375), 100, Color.PURPLE, 2, false)
		elif -(PI*0.875) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.625):
			draw_arc(playerPos, 40, -(PI*0.875), -(PI*0.625), 100, Color.PURPLE, 2, false)
		elif PI*0.875 < playerPos.angle_to_point(mousePos) or playerPos.angle_to_point(mousePos) -(PI*0.875):
			draw_arc(playerPos, 40, PI*0.875, PI, 100, Color.PURPLE, 2, false)
			draw_arc(playerPos, 40, -PI, -(PI*0.875), 100, Color.PURPLE, 2, false)
	draw_line(startPoint, endPoint, Color.LIME_GREEN, 2, false)

func _process(_delta: float) -> void:
	
	playerPos = Vector2(GetPlayer2dPosition.HorizontalPos, GetPlayer2dPosition.VerticalPos)
	mousePos = get_viewport().get_mouse_position()
	var rad = playerPos.angle_to_point(mousePos)
	startPoint = Vector2(playerPos.x + 25*cos(rad), playerPos.y + 25*sin(rad))
	endPoint = Vector2(playerPos.x + 65*cos(rad), playerPos.y + 65*sin(rad))
	
	queue_redraw()
