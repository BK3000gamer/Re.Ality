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
	if pivot.PivotRot == 0.0 and pivot.CurrentView == "Side":
		HorizontalPos = (player.global_transform.origin.x - pivot.global_transform.origin.x + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	elif pivot.PivotRot == -45.0 and pivot.CurrentView == "Side":
		var playerH = player.global_transform.origin.x + player.global_transform.origin.z
		var playerA = playerH*cos(deg_to_rad(45))
		var pivotH = pivot.global_transform.origin.x + pivot.global_transform.origin.z
		var pivotA = pivotH*cos(deg_to_rad(45))
		HorizontalPos = (playerA - pivotA + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	elif pivot.PivotRot == -90.0 and pivot.CurrentView == "Side":
		HorizontalPos = (player.global_transform.origin.z - pivot.global_transform.origin.z + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	elif pivot.PivotRot == -135.0 and pivot.CurrentView == "Side":
		var playerH = player.global_transform.origin.z - player.global_transform.origin.x
		var playerA = playerH*cos(deg_to_rad(45))
		var pivotH = pivot.global_transform.origin.z - pivot.global_transform.origin.x
		var pivotA = pivotH*cos(deg_to_rad(45))
		HorizontalPos = (playerA - pivotA + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	elif (pivot.PivotRot == -180.0 or pivot.PivotRot == 180.0) and pivot.CurrentView == "Side":
		HorizontalPos = 640 - (player.global_transform.origin.x - pivot.global_transform.origin.x + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	elif pivot.PivotRot == 135.0 and pivot.CurrentView == "Side":
		var playerH = player.global_transform.origin.x + player.global_transform.origin.z
		var playerA = playerH*cos(deg_to_rad(45))
		var pivotH = pivot.global_transform.origin.x + pivot.global_transform.origin.z
		var pivotA = pivotH*cos(deg_to_rad(45))
		HorizontalPos = (pivotA - playerA + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	elif pivot.PivotRot == 90.0 and pivot.CurrentView == "Side":
		HorizontalPos = 640 - (player.global_transform.origin.z - pivot.global_transform.origin.z + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	elif pivot.PivotRot == 45.0 and pivot.CurrentView == "Side":
		var playerH = player.global_transform.origin.z - player.global_transform.origin.x
		var playerA = playerH*cos(deg_to_rad(45))
		var pivotH = pivot.global_transform.origin.z - pivot.global_transform.origin.x
		var pivotA = pivotH*cos(deg_to_rad(45))
		HorizontalPos = (pivotA - playerA + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	elif pivot.PivotRot == 0.0 and pivot.CurrentView == "Middle":
		HorizontalPos = (player.global_transform.origin.x - pivot.global_transform.origin.x + 10) * 32
		var playerH = player.global_transform.origin.z - player.global_transform.origin.y
		var playerA = playerH*cos(deg_to_rad(45))
		var pivotH = pivot.global_transform.origin.z - pivot.global_transform.origin.y
		var pivotA = pivotH*cos(deg_to_rad(45))
		VerticalPos = (playerA - pivotA + 5.625) * 32
	elif pivot.PivotRot == -45.0 and pivot.CurrentView == "Middle":
		var playerH1 = player.global_transform.origin.x + player.global_transform.origin.z
		var playerA1 = playerH1*cos(deg_to_rad(45))
		var pivotH1 = pivot.global_transform.origin.x + pivot.global_transform.origin.z
		var pivotA1 = pivotH1*cos(deg_to_rad(45))
		HorizontalPos = (playerA1 - pivotA1 + 10) * 32
		var playerH2 = player.global_transform.origin.z - player.global_transform.origin.x
		var playerA2 = playerH2*cos(deg_to_rad(45))
		var playerB = playerA2 - player.global_transform.origin.y
		var playerB2 = playerB*cos(deg_to_rad(45))
		var pivotH2 = pivot.global_transform.origin.z - pivot.global_transform.origin.x
		var pivotA2 = pivotH2*cos(deg_to_rad(45))
		var pivotB = pivotA2 - pivot.global_transform.origin.y
		var pivotB2 = pivotB*cos(deg_to_rad(45))
		VerticalPos = (playerB2 - pivotB2 + 5.625) * 32
	elif pivot.PivotRot == -90.0 and pivot.CurrentView == "Middle":
		HorizontalPos = (player.global_transform.origin.z - pivot.global_transform.origin.z + 10) * 32
		var playerH = player.global_transform.origin.x + player.global_transform.origin.y
		var playerA = playerH*cos(deg_to_rad(45))
		var pivotH = pivot.global_transform.origin.x + pivot.global_transform.origin.y
		var pivotA = pivotH*cos(deg_to_rad(45))
		VerticalPos = (pivotA - playerA + 5.625) * 32
	elif pivot.PivotRot == -135.0 and pivot.CurrentView == "Middle":
		var playerH1 = player.global_transform.origin.z - player.global_transform.origin.x
		var playerA1 = playerH1*cos(deg_to_rad(45))
		var pivotH1 = pivot.global_transform.origin.z - pivot.global_transform.origin.x
		var pivotA1 = pivotH1*cos(deg_to_rad(45))
		HorizontalPos = (playerA1 - pivotA1 + 10) * 32
		var playerH2 = player.global_transform.origin.z + player.global_transform.origin.x
		var playerA2 = playerH2*cos(deg_to_rad(45))
		var playerB = playerA2 + player.global_transform.origin.y
		var playerB2 = playerB*cos(deg_to_rad(45))
		var pivotH2 = pivot.global_transform.origin.z + pivot.global_transform.origin.x
		var pivotA2 = pivotH2*cos(deg_to_rad(45))
		var pivotB = pivotA2 + pivot.global_transform.origin.y
		var pivotB2 = pivotB*cos(deg_to_rad(45))
		VerticalPos = (pivotB2 - playerB2 + 5.625) * 32
	elif (pivot.PivotRot == -180.0 or pivot.PivotRot == 180.0) and pivot.CurrentView == "Middle":
		HorizontalPos = 640 - (player.global_transform.origin.x - pivot.global_transform.origin.x + 10) * 32
		var playerH = player.global_transform.origin.y + player.global_transform.origin.z
		var playerA = playerH*cos(deg_to_rad(45))
		var pivotH = pivot.global_transform.origin.y + pivot.global_transform.origin.z
		var pivotA = pivotH*cos(deg_to_rad(45))
		VerticalPos = (pivotA - playerA + 5.625) * 32
	elif pivot.PivotRot == 135.0 and pivot.CurrentView == "Middle":
		var playerH1 = player.global_transform.origin.x + player.global_transform.origin.z
		var playerA1 = playerH1*cos(deg_to_rad(45))
		var pivotH1 = pivot.global_transform.origin.x + pivot.global_transform.origin.z
		var pivotA1 = pivotH1*cos(deg_to_rad(45))
		HorizontalPos = (pivotA1 - playerA1 + 10) * 32
		var playerH2 = player.global_transform.origin.z - player.global_transform.origin.x
		var playerA2 = playerH2*cos(deg_to_rad(45))
		var playerB = playerA2 + player.global_transform.origin.y
		var playerB2 = playerB*cos(deg_to_rad(45))
		var pivotH2 = pivot.global_transform.origin.z - pivot.global_transform.origin.x
		var pivotA2 = pivotH2*cos(deg_to_rad(45))
		var pivotB = pivotA2 + pivot.global_transform.origin.y
		var pivotB2 = pivotB*cos(deg_to_rad(45))
		VerticalPos = (pivotB2 - playerB2 + 5.625) * 32
	elif pivot.PivotRot == 90.0 and pivot.CurrentView == "Middle":
		HorizontalPos = 640 - (player.global_transform.origin.z - pivot.global_transform.origin.z + 10) * 32
		var playerH = player.global_transform.origin.x - player.global_transform.origin.y
		var playerA = playerH*cos(deg_to_rad(45))
		var pivotH = pivot.global_transform.origin.x - pivot.global_transform.origin.y
		var pivotA = pivotH*cos(deg_to_rad(45))
		VerticalPos = (playerA - pivotA + 5.625) * 32
	elif pivot.PivotRot == 45.0 and pivot.CurrentView == "Middle":
		var playerH1 = player.global_transform.origin.x - player.global_transform.origin.z
		var playerA1 = playerH1*cos(deg_to_rad(45))
		var pivotH1 = pivot.global_transform.origin.x - pivot.global_transform.origin.z
		var pivotA1 = pivotH1*cos(deg_to_rad(45))
		HorizontalPos = (playerA1 - pivotA1 + 10) * 32
		var playerH2 = player.global_transform.origin.z + player.global_transform.origin.x
		var playerA2 = playerH2*cos(deg_to_rad(45))
		var playerB = playerA2 - player.global_transform.origin.y
		var playerB2 = playerB*cos(deg_to_rad(45))
		var pivotH2 = pivot.global_transform.origin.z + pivot.global_transform.origin.x
		var pivotA2 = pivotH2*cos(deg_to_rad(45))
		var pivotB = pivotA2 - pivot.global_transform.origin.y
		var pivotB2 = pivotB*cos(deg_to_rad(45))
		VerticalPos = (playerB2 - pivotB2 + 5.625) * 32
	elif pivot.PivotRot == 0.0 and pivot.CurrentView == "Top":
		HorizontalPos = (player.global_transform.origin.x - pivot.global_transform.origin.x + 10) * 32
		VerticalPos = (player.global_transform.origin.z - pivot.global_transform.origin.z + 5.625) * 32
	elif pivot.PivotRot == -45.0 and pivot.CurrentView == "Top":
		var playerH1 = player.global_transform.origin.x + player.global_transform.origin.z
		var playerA1 = playerH1*cos(deg_to_rad(45))
		var pivotH1 = pivot.global_transform.origin.x + pivot.global_transform.origin.z
		var pivotA1 = pivotH1*cos(deg_to_rad(45))
		HorizontalPos = (playerA1 - pivotA1 + 10) * 32
		var playerH2 = player.global_transform.origin.z - player.global_transform.origin.x
		var playerA2 = playerH2*cos(deg_to_rad(45))
		var pivotH2 = pivot.global_transform.origin.z - pivot.global_transform.origin.x
		var pivotA2 = pivotH2*cos(deg_to_rad(45))
		VerticalPos = (playerA2 - pivotA2 +  5.625) * 32
	elif pivot.PivotRot == -90.0 and pivot.CurrentView == "Top":
		HorizontalPos = (player.global_transform.origin.z - pivot.global_transform.origin.z + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.x - pivot.global_transform.origin.x + 5.625) * 32
	elif pivot.PivotRot == -135.0 and pivot.CurrentView == "Top":
		var playerH1 = player.global_transform.origin.z - player.global_transform.origin.x
		var playerA1 = playerH1*cos(deg_to_rad(45))
		var pivotH1 = pivot.global_transform.origin.z - pivot.global_transform.origin.x
		var pivotA1 = pivotH1*cos(deg_to_rad(45))
		HorizontalPos = (playerA1 - pivotA1 + 10) * 32
		var playerH2 = player.global_transform.origin.z + player.global_transform.origin.x
		var playerA2 = playerH2*cos(deg_to_rad(45))
		var pivotH2 = pivot.global_transform.origin.z + pivot.global_transform.origin.x
		var pivotA2 = pivotH2*cos(deg_to_rad(45))
		VerticalPos = (pivotA2 - playerA2 +  5.625) * 32
	elif (pivot.PivotRot == -180.0 or pivot.PivotRot == 180.0) and pivot.CurrentView == "Top":
		HorizontalPos = 640 - (player.global_transform.origin.x - pivot.global_transform.origin.x + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.z - pivot.global_transform.origin.z + 5.625) * 32
	elif pivot.PivotRot == 135.0 and pivot.CurrentView == "Top":
		var playerH1 = player.global_transform.origin.x + player.global_transform.origin.z
		var playerA1 = playerH1*cos(deg_to_rad(45))
		var pivotH1 = pivot.global_transform.origin.x + pivot.global_transform.origin.z
		var pivotA1 = pivotH1*cos(deg_to_rad(45))
		HorizontalPos = (pivotA1 - playerA1 + 10) * 32
		var playerH2 = player.global_transform.origin.z - player.global_transform.origin.x
		var playerA2 = playerH2*cos(deg_to_rad(45))
		var pivotH2 = pivot.global_transform.origin.z - pivot.global_transform.origin.x
		var pivotA2 = pivotH2*cos(deg_to_rad(45))
		VerticalPos = (pivotA2 - playerA2 +  5.625) * 32
	elif pivot.PivotRot == 90.0 and pivot.CurrentView == "Top":
		HorizontalPos = 640 - (player.global_transform.origin.z - pivot.global_transform.origin.z + 10) * 32
		VerticalPos = (player.global_transform.origin.x - pivot.global_transform.origin.x + 5.625) * 32
	elif pivot.PivotRot == 45.0 and pivot.CurrentView == "Top":
		var playerH1 = player.global_transform.origin.x - player.global_transform.origin.z
		var playerA1 = playerH1*cos(deg_to_rad(45))
		var pivotH1 = pivot.global_transform.origin.x - pivot.global_transform.origin.z
		var pivotA1 = pivotH1*cos(deg_to_rad(45))
		HorizontalPos = (playerA1 - pivotA1 + 10) * 32
		var playerH2 = player.global_transform.origin.z + player.global_transform.origin.x
		var playerA2 = playerH2*cos(deg_to_rad(45))
		var pivotH2 = pivot.global_transform.origin.z + pivot.global_transform.origin.x
		var pivotA2 = pivotH2*cos(deg_to_rad(45))
		VerticalPos = (playerA2 - pivotA2 +  5.625) * 32
	
	playerPos = Vector2(HorizontalPos, VerticalPos)
	mousePos = get_viewport().get_mouse_position()
	var rad = playerPos.angle_to_point(mousePos)
	startPoint = Vector2(playerPos.x + 25*cos(rad), playerPos.y + 25*sin(rad))
	endPoint = Vector2(playerPos.x + 65*cos(rad), playerPos.y + 65*sin(rad))
	
	queue_redraw()
