extends Node2D

var player: Player
var pivot: Pivot
var playerPos: Vector2
var mousePos: Vector2

var startPoint: Vector2
var endPoint: Vector2
var point1: Vector2
var point2: Vector2

var HorizontalPos: float
var VerticalPos: float

@export var green: Color
@export var purple: Color

func _draw() -> void:
	if pivot.CurrentView == "Side":
		if  -(PI*0.25) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.25:
			draw_arc(playerPos, 38, -(PI*0.25), PI*0.25, 100, green, 1, false)
			draw_arc(playerPos, 42, -(PI*0.25), PI*0.25, 100, green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(-(PI*0.25)), playerPos.y + 42*sin(-(PI*0.25))), Vector2(playerPos.x + 38*cos(-(PI*0.1875)), playerPos.y + 38*sin(-(PI*0.1875))), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(-(PI*0.1875)), playerPos.y + 38*sin(-(PI*0.1875))), Vector2(playerPos.x + 42*cos(-(PI*0.125)), playerPos.y + 42*sin(-(PI*0.125))), green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(-(PI*0.125)), playerPos.y + 42*sin(-(PI*0.125))), Vector2(playerPos.x + 38*cos(-(PI*0.0625)), playerPos.y + 38*sin(-(PI*0.0625))), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(-(PI*0.0625)), playerPos.y + 38*sin(-(PI*0.0625))), Vector2(playerPos.x + 42*cos(0), playerPos.y + 42*sin(0)), green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(0), playerPos.y + 42*sin(0)), Vector2(playerPos.x + 38*cos(PI*0.0625), playerPos.y + 38*sin(PI*0.0625)), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(PI*0.0625), playerPos.y + 38*sin(PI*0.0625)), Vector2(playerPos.x + 42*cos(PI*0.125), playerPos.y + 42*sin(PI*0.125)), green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(PI*0.125), playerPos.y + 42*sin(PI*0.125)), Vector2(playerPos.x + 38*cos(PI*0.1875), playerPos.y + 38*sin(PI*0.1875)), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(PI*0.1875), playerPos.y + 38*sin(PI*0.1875)), Vector2(playerPos.x + 42*cos(PI*0.25), playerPos.y + 42*sin(PI*0.25)), green, 1, false)
		elif -(PI*0.75) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.25):
			draw_arc(playerPos, 38, -(PI*0.75), -(PI*0.25), 100, green, 1, false)
			draw_arc(playerPos, 42, -(PI*0.75), -(PI*0.25), 100, green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(-(PI*0.75)), playerPos.y + 42*sin(-(PI*0.75))), Vector2(playerPos.x + 38*cos(-(PI*0.6875)), playerPos.y + 38*sin(-(PI*0.6875))), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(-(PI*0.6875)), playerPos.y + 38*sin(-(PI*0.6875))), Vector2(playerPos.x + 42*cos(-(PI*0.625)), playerPos.y + 42*sin(-(PI*0.625))), green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(-(PI*0.625)), playerPos.y + 42*sin(-(PI*0.625))), Vector2(playerPos.x + 38*cos(-(PI*0.5625)), playerPos.y + 38*sin(-(PI*0.5625))), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(-(PI*0.5625)), playerPos.y + 38*sin(-(PI*0.5625))), Vector2(playerPos.x + 42*cos(-(PI*0.5)), playerPos.y + 42*sin(-(PI*0.5))), green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(-(PI*0.5)), playerPos.y + 42*sin(-(PI*0.5))), Vector2(playerPos.x + 38*cos(-(PI*0.4375)), playerPos.y + 38*sin(-(PI*0.4375))), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(-(PI*0.4375)), playerPos.y + 38*sin(-(PI*0.4375))), Vector2(playerPos.x + 42*cos(-(PI*0.375)), playerPos.y + 42*sin(-(PI*0.375))), green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(-(PI*0.375)), playerPos.y + 42*sin(-(PI*0.375))), Vector2(playerPos.x + 38*cos(-(PI*0.3125)), playerPos.y + 38*sin(-(PI*0.3125))), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(-(PI*0.3125)), playerPos.y + 38*sin(-(PI*0.3125))), Vector2(playerPos.x + 42*cos(-(PI*0.25)), playerPos.y + 42*sin(-(PI*0.25))), green, 1, false)
		elif PI*0.25 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.75:
			if !player.is_on_floor() or player.CurrentState == "Crouch":
				draw_arc(playerPos, 38, PI*0.25, PI*0.75, 100, green, 1, false)
				draw_arc(playerPos, 42, PI*0.25, PI*0.75, 100, green, 1, false)
				draw_line(Vector2(playerPos.x + 42*cos(PI*0.75), playerPos.y + 42*sin(PI*0.75)), Vector2(playerPos.x + 38*cos(PI*0.6875), playerPos.y + 38*sin(PI*0.6875)), green, 1, false)
				draw_line(Vector2(playerPos.x + 38*cos(PI*0.6875), playerPos.y + 38*sin(PI*0.6875)), Vector2(playerPos.x + 42*cos(PI*0.625), playerPos.y + 42*sin(PI*0.625)), green, 1, false)
				draw_line(Vector2(playerPos.x + 42*cos(PI*0.625), playerPos.y + 42*sin(PI*0.625)), Vector2(playerPos.x + 38*cos(PI*0.5625), playerPos.y + 38*sin(PI*0.5625)), green, 1, false)
				draw_line(Vector2(playerPos.x + 38*cos(PI*0.5625), playerPos.y + 38*sin(PI*0.5625)), Vector2(playerPos.x + 42*cos(PI*0.5), playerPos.y + 42*sin(PI*0.5)), green, 1, false)
				draw_line(Vector2(playerPos.x + 42*cos(PI*0.5), playerPos.y + 42*sin(PI*0.5)), Vector2(playerPos.x + 38*cos(PI*0.4375), playerPos.y + 38*sin(PI*0.4375)), green, 1, false)
				draw_line(Vector2(playerPos.x + 38*cos(PI*0.4375), playerPos.y + 38*sin(PI*0.4375)), Vector2(playerPos.x + 42*cos(PI*0.375), playerPos.y + 42*sin(PI*0.375)), green, 1, false)
				draw_line(Vector2(playerPos.x + 42*cos(PI*0.375), playerPos.y + 42*sin(PI*0.375)), Vector2(playerPos.x + 38*cos(PI*0.3125), playerPos.y + 38*sin(PI*0.3125)), green, 1, false)
				draw_line(Vector2(playerPos.x + 38*cos(PI*0.3125), playerPos.y + 38*sin(PI*0.3125)), Vector2(playerPos.x + 42*cos(PI*0.25), playerPos.y + 42*sin(PI*0.25)), green, 1, false)
		elif PI*0.75 < playerPos.angle_to_point(mousePos) or playerPos.angle_to_point(mousePos) < -(PI*0.75):
			draw_arc(playerPos, 38, PI*0.75, PI, 100, green, 1, false)
			draw_arc(playerPos, 38, -PI, -(PI*0.75), 100, green, 1, false)
			draw_arc(playerPos, 42, PI*0.75, PI, 100, green, 1, false)
			draw_arc(playerPos, 42, -PI, -(PI*0.75), 100, green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(PI*0.75), playerPos.y + 42*sin(PI*0.75)), Vector2(playerPos.x + 38*cos(PI*0.8125), playerPos.y + 38*sin(PI*0.8125)), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(PI*0.8125), playerPos.y + 38*sin(PI*0.8125)), Vector2(playerPos.x + 42*cos(PI*0.875), playerPos.y + 42*sin(PI*0.875)), green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(PI*0.875), playerPos.y + 42*sin(PI*0.875)), Vector2(playerPos.x + 38*cos(PI*0.9375), playerPos.y + 38*sin(PI*0.9375)), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(PI*0.9375), playerPos.y + 38*sin(PI*0.9375)), Vector2(playerPos.x + 42*cos(PI), playerPos.y + 42*sin(PI)), green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(PI), playerPos.y + 42*sin(PI)), Vector2(playerPos.x + 38*cos(-(PI*0.9375)), playerPos.y + 38*sin(-(PI*0.9375))), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(-(PI*0.9375)), playerPos.y + 38*sin(-(PI*0.9375))), Vector2(playerPos.x + 42*cos(-(PI*0.875)), playerPos.y + 42*sin(-(PI*0.875))), green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(-(PI*0.875)), playerPos.y + 42*sin(-(PI*0.875))), Vector2(playerPos.x + 38*cos(-(PI*0.8125)), playerPos.y + 38*sin(-(PI*0.8125))), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(-(PI*0.8125)), playerPos.y + 38*sin(-(PI*0.8125))), Vector2(playerPos.x + 42*cos(-(PI*0.75)), playerPos.y + 42*sin(-(PI*0.75))), green, 1, false)
	else:
		if  PI*0.625 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.875:
			draw_arc(playerPos, 38, PI*0.625, PI*0.875, 100, green, 1, false)
			draw_arc(playerPos, 42, PI*0.625, PI*0.875, 100, green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(PI*0.75), playerPos.y + 42*sin(PI*0.75)), Vector2(playerPos.x + 38*cos(PI*0.6875), playerPos.y + 38*sin(PI*0.6875)), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(PI*0.6875), playerPos.y + 38*sin(PI*0.6875)), Vector2(playerPos.x + 42*cos(PI*0.625), playerPos.y + 42*sin(PI*0.625)), green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(PI*0.75), playerPos.y + 42*sin(PI*0.75)), Vector2(playerPos.x + 38*cos(PI*0.8125), playerPos.y + 38*sin(PI*0.8125)), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(PI*0.8125), playerPos.y + 38*sin(PI*0.8125)), Vector2(playerPos.x + 42*cos(PI*0.875), playerPos.y + 42*sin(PI*0.875)), green, 1, false)
		elif  PI*0.375 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.625:
			draw_arc(playerPos, 38, PI*0.375, PI*0.625, 100, green, 1, false)
			draw_arc(playerPos, 42, PI*0.375, PI*0.625, 100, green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(PI*0.625), playerPos.y + 42*sin(PI*0.625)), Vector2(playerPos.x + 38*cos(PI*0.5625), playerPos.y + 38*sin(PI*0.5625)), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(PI*0.5625), playerPos.y + 38*sin(PI*0.5625)), Vector2(playerPos.x + 42*cos(PI*0.5), playerPos.y + 42*sin(PI*0.5)), green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(PI*0.5), playerPos.y + 42*sin(PI*0.5)), Vector2(playerPos.x + 38*cos(PI*0.4375), playerPos.y + 38*sin(PI*0.4375)), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(PI*0.4375), playerPos.y + 38*sin(PI*0.4375)), Vector2(playerPos.x + 42*cos(PI*0.375), playerPos.y + 42*sin(PI*0.375)), green, 1, false)
		elif  PI*0.125 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.375:
			draw_arc(playerPos, 38, PI*0.125, PI*0.375, 100, green, 1, false)
			draw_arc(playerPos, 42, PI*0.125, PI*0.375, 100, green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(PI*0.375), playerPos.y + 42*sin(PI*0.375)), Vector2(playerPos.x + 38*cos(PI*0.3125), playerPos.y + 38*sin(PI*0.3125)), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(PI*0.3125), playerPos.y + 38*sin(PI*0.3125)), Vector2(playerPos.x + 42*cos(PI*0.25), playerPos.y + 42*sin(PI*0.25)), green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(PI*0.125), playerPos.y + 42*sin(PI*0.125)), Vector2(playerPos.x + 38*cos(PI*0.1875), playerPos.y + 38*sin(PI*0.1875)), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(PI*0.1875), playerPos.y + 38*sin(PI*0.1875)), Vector2(playerPos.x + 42*cos(PI*0.25), playerPos.y + 42*sin(PI*0.25)), green, 1, false)
		elif  -(PI*0.125) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.125:
			draw_arc(playerPos, 38, -(PI*0.125), PI*0.125, 100, green, 1, false)
			draw_arc(playerPos, 42, -(PI*0.125), PI*0.125, 100, green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(0), playerPos.y + 42*sin(0)), Vector2(playerPos.x + 38*cos(PI*0.0625), playerPos.y + 38*sin(PI*0.0625)), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(PI*0.0625), playerPos.y + 38*sin(PI*0.0625)), Vector2(playerPos.x + 42*cos(PI*0.125), playerPos.y + 42*sin(PI*0.125)), green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(-(PI*0.125)), playerPos.y + 42*sin(-(PI*0.125))), Vector2(playerPos.x + 38*cos(-(PI*0.0625)), playerPos.y + 38*sin(-(PI*0.0625))), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(-(PI*0.0625)), playerPos.y + 38*sin(-(PI*0.0625))), Vector2(playerPos.x + 42*cos(0), playerPos.y + 42*sin(0)), green, 1, false)
		elif -(PI*0.375) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.125):
			draw_arc(playerPos, 38, -(PI*0.375), -(PI*0.125), 100, green, 1, false)
			draw_arc(playerPos, 42, -(PI*0.375), -(PI*0.125), 100, green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(-(PI*0.25)), playerPos.y + 42*sin(-(PI*0.25))), Vector2(playerPos.x + 38*cos(-(PI*0.1875)), playerPos.y + 38*sin(-(PI*0.1875))), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(-(PI*0.1875)), playerPos.y + 38*sin(-(PI*0.1875))), Vector2(playerPos.x + 42*cos(-(PI*0.125)), playerPos.y + 42*sin(-(PI*0.125))), green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(-(PI*0.375)), playerPos.y + 42*sin(-(PI*0.375))), Vector2(playerPos.x + 38*cos(-(PI*0.3125)), playerPos.y + 38*sin(-(PI*0.3125))), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(-(PI*0.3125)), playerPos.y + 38*sin(-(PI*0.3125))), Vector2(playerPos.x + 42*cos(-(PI*0.25)), playerPos.y + 42*sin(-(PI*0.25))), green, 1, false)
		elif -(PI*0.625) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.375):
			draw_arc(playerPos, 38, -(PI*0.625), -(PI*0.375), 100, green, 1, false)
			draw_arc(playerPos, 42, -(PI*0.625), -(PI*0.375), 100, green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(-(PI*0.625)), playerPos.y + 42*sin(-(PI*0.625))), Vector2(playerPos.x + 38*cos(-(PI*0.5625)), playerPos.y + 38*sin(-(PI*0.5625))), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(-(PI*0.5625)), playerPos.y + 38*sin(-(PI*0.5625))), Vector2(playerPos.x + 42*cos(-(PI*0.5)), playerPos.y + 42*sin(-(PI*0.5))), green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(-(PI*0.5)), playerPos.y + 42*sin(-(PI*0.5))), Vector2(playerPos.x + 38*cos(-(PI*0.4375)), playerPos.y + 38*sin(-(PI*0.4375))), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(-(PI*0.4375)), playerPos.y + 38*sin(-(PI*0.4375))), Vector2(playerPos.x + 42*cos(-(PI*0.375)), playerPos.y + 42*sin(-(PI*0.375))), green, 1, false)
		elif -(PI*0.875) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.625):
			draw_arc(playerPos, 38, -(PI*0.875), -(PI*0.625), 100, green, 1, false)
			draw_arc(playerPos, 42, -(PI*0.875), -(PI*0.625), 100, green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(-(PI*0.875)), playerPos.y + 42*sin(-(PI*0.875))), Vector2(playerPos.x + 38*cos(-(PI*0.8125)), playerPos.y + 38*sin(-(PI*0.8125))), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(-(PI*0.8125)), playerPos.y + 38*sin(-(PI*0.8125))), Vector2(playerPos.x + 42*cos(-(PI*0.75)), playerPos.y + 42*sin(-(PI*0.75))), green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(-(PI*0.75)), playerPos.y + 42*sin(-(PI*0.75))), Vector2(playerPos.x + 38*cos(-(PI*0.6875)), playerPos.y + 38*sin(-(PI*0.6875))), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(-(PI*0.6875)), playerPos.y + 38*sin(-(PI*0.6875))), Vector2(playerPos.x + 42*cos(-(PI*0.625)), playerPos.y + 42*sin(-(PI*0.625))), green, 1, false)
		elif PI*0.875 < playerPos.angle_to_point(mousePos) or playerPos.angle_to_point(mousePos) -(PI*0.875):
			draw_arc(playerPos, 38, PI*0.875, PI, 100, green, 1, false)
			draw_arc(playerPos, 38, -PI, -(PI*0.875), 100, green, 1, false)
			draw_arc(playerPos, 42, PI*0.875, PI, 100, green, 1, false)
			draw_arc(playerPos, 42, -PI, -(PI*0.875), 100, green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(PI*0.875), playerPos.y + 42*sin(PI*0.875)), Vector2(playerPos.x + 38*cos(PI*0.9375), playerPos.y + 38*sin(PI*0.9375)), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(PI*0.9375), playerPos.y + 38*sin(PI*0.9375)), Vector2(playerPos.x + 42*cos(PI), playerPos.y + 42*sin(PI)), green, 1, false)
			draw_line(Vector2(playerPos.x + 42*cos(PI), playerPos.y + 42*sin(PI)), Vector2(playerPos.x + 38*cos(-(PI*0.9375)), playerPos.y + 38*sin(-(PI*0.9375))), green, 1, false)
			draw_line(Vector2(playerPos.x + 38*cos(-(PI*0.9375)), playerPos.y + 38*sin(-(PI*0.9375))), Vector2(playerPos.x + 42*cos(-(PI*0.875)), playerPos.y + 42*sin(-(PI*0.875))), green, 1, false)
	draw_line(startPoint, endPoint, purple, 1, false)
	draw_line(point1, endPoint, purple, 1, false)
	draw_line(endPoint, point2, purple, 1, false)
	draw_line(point2, startPoint, purple, 1, false)
	draw_line(startPoint, point1, purple, 1, false)
	draw_line(point2, point1, purple, 1, false)

func _process(_delta: float) -> void:
	
	playerPos = Vector2(GetPlayer2dPosition.HorizontalPos, GetPlayer2dPosition.VerticalPos)
	mousePos = get_viewport().get_mouse_position()
	var rad = playerPos.angle_to_point(mousePos)
	startPoint = Vector2(playerPos.x + 32*cos(rad), playerPos.y + 32*sin(rad))
	endPoint = Vector2(playerPos.x + 52*cos(rad), playerPos.y + 52*sin(rad))
	point1 = Vector2(playerPos.x + 38*cos(rad - PI*0.02), playerPos.y + 38*sin(rad - PI*0.02))
	point2 = Vector2(playerPos.x + 38*cos(rad + PI*0.02), playerPos.y + 38*sin(rad + PI*0.02))
	
	queue_redraw()
