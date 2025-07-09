extends Node

var pivot: Pivot
var player: Player

var PlayerPos
var PivotPos
var HorizontalPos: float
var VerticalPos: float
var MousePos
var MouseDir: Vector3

var TargetPos

@export_category("Movement Stats")
@export var HorizontalDeadZone: float
@export var VerticalDeadZone: float
@export var LookAheadDistance: float
var FollowSpeed

func init(Parent: Pivot) -> void:
	pivot = Parent

func init_sibling(PlayerName: String) -> void:
	var parent = get_parent().get_parent()
	
	var SiblingPlayer = parent.get_node_or_null(PlayerName)
	if SiblingPlayer == null:
		push_warning("Player node not found.")
		return
	
	player = SiblingPlayer

func _process(delta: float) -> void:
	MousePos = get_viewport().get_mouse_position()
	MouseDir = Vector3.ZERO
	
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
	
	var playerPos = Vector2(HorizontalPos, VerticalPos)
	
	if  -(PI*0.25) < playerPos.angle_to_point(MousePos) and playerPos.angle_to_point(MousePos) < PI*0.25:
		MouseDir.x = 1
	elif -(PI*0.75) < playerPos.angle_to_point(MousePos) and playerPos.angle_to_point(MousePos) < -(PI*0.25):
		if pivot.CurrentView == "Side":
			MouseDir.y = -1
		else:
			MouseDir.z = -1
	elif PI*0.25 < playerPos.angle_to_point(MousePos) and playerPos.angle_to_point(MousePos) < PI*0.75:
		if pivot.CurrentView == "Side":
			MouseDir.y = 1
		else:
			MouseDir.z = 1
	elif PI*0.75 < playerPos.angle_to_point(MousePos) or playerPos.angle_to_point(MousePos) -(PI*0.75):
		MouseDir.x = -1
	
	MouseDir = MouseDir.rotated(Vector3.UP, pivot.rotation.y).normalized()

func _physics_process(delta: float) -> void:
	PlayerPos = player.global_position
	PivotPos = pivot.global_position
	TargetPos = PivotPos
	FollowSpeed = player.velocity
	
	if player.CurrentState == "Super Jump":
		FollowSpeed = player.velocity * 2
	
	if Input.is_action_pressed("look_ahead") and player.CurrentState == "Idle":
		TargetPos = PlayerPos + MouseDir.normalized() * LookAheadDistance
		PivotPos.x = move_toward(PivotPos.x, TargetPos.x, 10 * delta)
		PivotPos.y = move_toward(PivotPos.y, TargetPos.y, 10 * delta)
		PivotPos.z = move_toward(PivotPos.z, TargetPos.z, 10 * delta)
		
	if Input.is_action_just_released("look_ahead"):
		PivotPos = PlayerPos
	
	if abs(PlayerPos.x - PivotPos.x) > HorizontalDeadZone:
				TargetPos.x = PlayerPos.x
				PivotPos.x = move_toward(PivotPos.x, TargetPos.x, abs(FollowSpeed.x) * delta)
	
	if abs(PlayerPos.z - PivotPos.z) > HorizontalDeadZone:
				TargetPos.z = PlayerPos.z
				PivotPos.z = move_toward(PivotPos.z, TargetPos.z, abs(FollowSpeed.z) * delta)
	
	if abs(PlayerPos.y - PivotPos.y) > HorizontalDeadZone:
				TargetPos.y = PlayerPos.y
				PivotPos.y = move_toward(PivotPos.y, TargetPos.y, abs(FollowSpeed.y) * delta)
	
	if pivot.RoomType.size() > 0:
		if pivot.RoomType[0] == 1:
			if pivot.CurrentState == "TopZ" or pivot.CurrentState == "MiddleZ" or pivot.CurrentState == "SideZ":
				if PivotPos.x < (pivot.RoomPos.x - 4.375):
					PivotPos.x = (pivot.RoomPos.x - 4.375)
					TargetPos.x = (pivot.RoomPos.x - 4.375)
			elif pivot.CurrentState == "TopX" or pivot.CurrentState == "MiddleX" or pivot.CurrentState == "SideX":
				if PivotPos.x < pivot.RoomPos.x:
					PivotPos.x = pivot.RoomPos.x
					TargetPos.x = pivot.RoomPos.x
		
		if pivot.RoomType[0] == -1:
			if pivot.CurrentState == "TopZ" or pivot.CurrentState == "MiddleZ" or pivot.CurrentState == "SideZ":
				if PivotPos.x > (pivot.RoomPos.x + 4.375):
					PivotPos.x = (pivot.RoomPos.x + 4.375)
					TargetPos.x = (pivot.RoomPos.x + 4.375)
			elif pivot.CurrentState == "TopX" or pivot.CurrentState == "MiddleX" or pivot.CurrentState == "SideX":
				if PivotPos.x > pivot.RoomPos.x:
					PivotPos.x = pivot.RoomPos.x
					TargetPos.x = pivot.RoomPos.x
		
		if pivot.RoomType[0] == 0:
			if pivot.CurrentState == "TopZ" or pivot.CurrentState == "MiddleZ" or pivot.CurrentState == "SideZ":
				if PivotPos.x < (pivot.RoomPos.x - 4.375):
					PivotPos.x = (pivot.RoomPos.x - 4.375)
					TargetPos.x = (pivot.RoomPos.x - 4.375)
				elif PivotPos.x > (pivot.RoomPos.x + 4.375):
					PivotPos.x = (pivot.RoomPos.x + 4.375)
					TargetPos.x = (pivot.RoomPos.x + 4.375)
			elif pivot.CurrentState == "TopX" or pivot.CurrentState == "MiddleX" or pivot.CurrentState == "SideX":
				if PivotPos.x > pivot.RoomPos.x:
					PivotPos.x = pivot.RoomPos.x
					TargetPos.x = pivot.RoomPos.x
				elif PivotPos.x < pivot.RoomPos.x:
					PivotPos.x = pivot.RoomPos.x
					TargetPos.x = pivot.RoomPos.x
		
		if pivot.RoomType[2] == 1:
			if pivot.CurrentState == "TopX" or pivot.CurrentState == "MiddleX" or pivot.CurrentState == "SideX":
				if PivotPos.z < (pivot.RoomPos.z - 4.375):
					PivotPos.z = (pivot.RoomPos.z - 4.375)
					TargetPos.z = (pivot.RoomPos.z - 4.375)
			else:
				if PivotPos.z < pivot.RoomPos.z:
					PivotPos.z = pivot.RoomPos.z
					TargetPos.z = pivot.RoomPos.z
		
		if pivot.RoomType[2] == -1:
			if pivot.CurrentState == "TopX" or pivot.CurrentState == "MiddleX" or pivot.CurrentState == "SideX":
				if PivotPos.z > (pivot.RoomPos.z + 4.375):
					PivotPos.z = (pivot.RoomPos.z + 4.375)
					TargetPos.z = (pivot.RoomPos.z + 4.375)
			elif pivot.CurrentState == "TopZ" or pivot.CurrentState == "MiddleZ" or pivot.CurrentState == "SideZ":
				if PivotPos.z > pivot.RoomPos.z:
					PivotPos.z = pivot.RoomPos.z
					TargetPos.z = pivot.RoomPos.z
		
		if pivot.RoomType[2] == 0:
			if pivot.CurrentState == "TopX" or pivot.CurrentState == "MiddleX" or pivot.CurrentState == "SideX":
				if PivotPos.z < (pivot.RoomPos.z - 4.375):
					PivotPos.z = (pivot.RoomPos.z - 4.375)
					TargetPos.z = (pivot.RoomPos.z - 4.375)
				elif PivotPos.z > (pivot.RoomPos.z + 4.375):
					PivotPos.z = (pivot.RoomPos.z + 4.375)
					TargetPos.z = (pivot.RoomPos.z + 4.375)
			elif pivot.CurrentState == "TopZ" or pivot.CurrentState == "MiddleZ" or pivot.CurrentState == "SideZ":
				if PivotPos.z > pivot.RoomPos.z:
					PivotPos.z = pivot.RoomPos.z
					TargetPos.z = pivot.RoomPos.z
				elif PivotPos.z < pivot.RoomPos.z:
					PivotPos.z = pivot.RoomPos.z
					TargetPos.z = pivot.RoomPos.z
		
		if pivot.RoomType[1] == 1:
			if PivotPos.y < pivot.RoomPos.y:
					PivotPos.y = pivot.RoomPos.y
					TargetPos.y = pivot.RoomPos.y
		
		if pivot.RoomType[1] == -1:
			if PivotPos.y > pivot.RoomPos.y:
					PivotPos.y = pivot.RoomPos.y
					TargetPos.y = pivot.RoomPos.y
		
		if pivot.RoomType[1] == 0:
			if PivotPos.y < pivot.RoomPos.y:
					PivotPos.y = pivot.RoomPos.y
					TargetPos.y = pivot.RoomPos.y
			elif PivotPos.y > pivot.RoomPos.y:
					PivotPos.y = pivot.RoomPos.y
					TargetPos.y = pivot.RoomPos.y
	
	pivot.global_position = PivotPos
