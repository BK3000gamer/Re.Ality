extends Node2D

var player: Player
var pivot: Pivot
var playerPos: Vector2
var mousePos: Vector2
var startPoint: Vector2
var endPoint: Vector2
var HorizontalPos
var VerticalPos 

func _draw() -> void:
	draw_circle(playerPos, 40, Color.WHITE, false, 2, false)
	draw_line(startPoint, endPoint, Color.WHITE, 2, false)

func _process(delta: float) -> void:
	if pivot.CurrentState == "SideWE":
		HorizontalPos = ( player.global_transform.origin.x - pivot.global_transform.origin.x + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	elif pivot.CurrentState == "SideNS":
		HorizontalPos = ( player.global_transform.origin.z - pivot.global_transform.origin.z + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	playerPos = Vector2(HorizontalPos, VerticalPos)
	mousePos = get_viewport().get_mouse_position()
	var rad = playerPos.angle_to_point(mousePos)
	var angle = rad_to_deg(rad)
	startPoint = Vector2(playerPos.x + 25*cos(rad), playerPos.y + 25*sin(rad))
	endPoint = Vector2(playerPos.x + 55*cos(rad), playerPos.y + 55*sin(rad))
	
	queue_redraw()
