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
	
	if pivot.PivotRot == 0.0 and pivot.IsInSideView:
		HorizontalPos = (player.global_transform.origin.x - pivot.global_transform.origin.x + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	elif pivot.PivotRot == -90.0 and pivot.IsInSideView:
		HorizontalPos = (player.global_transform.origin.z - pivot.global_transform.origin.z + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	elif (pivot.PivotRot == -180.0 or pivot.PivotRot == 180.0) and pivot.IsInSideView:
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
	elif (pivot.PivotRot == -180.0 or pivot.PivotRot == 180.0) and !pivot.IsInSideView:
		HorizontalPos = 640 - (player.global_transform.origin.x - pivot.global_transform.origin.x + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.z - pivot.global_transform.origin.z + 5.625) * 32
	elif pivot.PivotRot == 90.0 and !pivot.IsInSideView:
		HorizontalPos = 640 - (player.global_transform.origin.z - pivot.global_transform.origin.z + 10) * 32
		VerticalPos = (player.global_transform.origin.x - pivot.global_transform.origin.x + 5.625) * 32
	
	var playerPos = Vector2(HorizontalPos, VerticalPos)
	
	if  -(PI*0.25) < playerPos.angle_to_point(MousePos) and playerPos.angle_to_point(MousePos) < PI*0.25:
		MouseDir.x = 1
	elif -(PI*0.75) < playerPos.angle_to_point(MousePos) and playerPos.angle_to_point(MousePos) < -(PI*0.25):
		if pivot.IsInSideView:
			MouseDir.y = -1
		else:
			MouseDir.z = -1
	elif PI*0.25 < playerPos.angle_to_point(MousePos) and playerPos.angle_to_point(MousePos) < PI*0.75:
		if pivot.IsInSideView:
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
		TargetPos = PivotPos + MouseDir * LookAheadDistance
		PivotPos.x = move_toward(PivotPos.x, TargetPos.x, 10 * delta)
		PivotPos.y = move_toward(PivotPos.y, TargetPos.y, 10 * delta)
		PivotPos.z = move_toward(PivotPos.z, TargetPos.z, 10 * delta)
		if abs(PlayerPos.x - PivotPos.x) > LookAheadDistance:
			TargetPos.x = PlayerPos.x + MouseDir.x * LookAheadDistance
			PivotPos.x = PlayerPos.x + MouseDir.x * LookAheadDistance
		if abs(PlayerPos.y - PivotPos.y) > LookAheadDistance:
			TargetPos.y = PlayerPos.y + MouseDir.y * LookAheadDistance
			PivotPos.y = PlayerPos.y + MouseDir.y * LookAheadDistance
		if abs(PlayerPos.z - PivotPos.z) > LookAheadDistance:
			TargetPos.z = PlayerPos.z + MouseDir.z * LookAheadDistance
			PivotPos.z = PlayerPos.z + MouseDir.z * LookAheadDistance
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
			if pivot.CurrentState == "TopNS" or pivot.CurrentState == "SideNS":
				if PivotPos.x < (pivot.RoomPos.x - 4.375):
					PivotPos.x = (pivot.RoomPos.x - 4.375)
					TargetPos.x = (pivot.RoomPos.x - 4.375)
			else:
				if PivotPos.x < pivot.RoomPos.x:
					PivotPos.x = pivot.RoomPos.x
					TargetPos.x = pivot.RoomPos.x
		
		if pivot.RoomType[0] == -1:
			if pivot.CurrentState == "TopNS" or pivot.CurrentState == "SideNS":
				if PivotPos.x > (pivot.RoomPos.x + 4.375):
					PivotPos.x = (pivot.RoomPos.x + 4.375)
					TargetPos.x = (pivot.RoomPos.x + 4.375)
			else:
				if PivotPos.x > pivot.RoomPos.x:
					PivotPos.x = pivot.RoomPos.x
					TargetPos.x = pivot.RoomPos.x
		
		if pivot.RoomType[0] == 0:
			if pivot.CurrentState == "TopNS" or pivot.CurrentState == "SideNS":
				if PivotPos.x < (pivot.RoomPos.x - 4.375):
					PivotPos.x = (pivot.RoomPos.x - 4.375)
					TargetPos.x = (pivot.RoomPos.x - 4.375)
				elif PivotPos.x > (pivot.RoomPos.x + 4.375):
					PivotPos.x = (pivot.RoomPos.x + 4.375)
					TargetPos.x = (pivot.RoomPos.x + 4.375)
			else:
				if PivotPos.x > pivot.RoomPos.x:
					PivotPos.x = pivot.RoomPos.x
					TargetPos.x = pivot.RoomPos.x
				elif PivotPos.x < pivot.RoomPos.x:
					PivotPos.x = pivot.RoomPos.x
					TargetPos.x = pivot.RoomPos.x
		
		if pivot.RoomType[2] == 1:
			if pivot.CurrentState == "TopWE" or pivot.CurrentState == "SideWE":
				if PivotPos.z < (pivot.RoomPos.z - 4.375):
					PivotPos.z = (pivot.RoomPos.z - 4.375)
					TargetPos.z = (pivot.RoomPos.z - 4.375)
			else:
				if PivotPos.z < pivot.RoomPos.z:
					PivotPos.z = pivot.RoomPos.z
					TargetPos.z = pivot.RoomPos.z
		
		if pivot.RoomType[2] == -1:
			if pivot.CurrentState == "TopWE" or pivot.CurrentState == "SideWE":
				if PivotPos.z > (pivot.RoomPos.z + 4.375):
					PivotPos.z = (pivot.RoomPos.z + 4.375)
					TargetPos.z = (pivot.RoomPos.z + 4.375)
			else:
				if PivotPos.z > pivot.RoomPos.z:
					PivotPos.z = pivot.RoomPos.z
					TargetPos.z = pivot.RoomPos.z
		
		if pivot.RoomType[2] == 0:
			if pivot.CurrentState == "TopWE" or pivot.CurrentState == "SideWE":
				if PivotPos.z < (pivot.RoomPos.z - 4.375):
					PivotPos.z = (pivot.RoomPos.z - 4.375)
					TargetPos.z = (pivot.RoomPos.z - 4.375)
				elif PivotPos.z > (pivot.RoomPos.z + 4.375):
					PivotPos.z = (pivot.RoomPos.z + 4.375)
					TargetPos.z = (pivot.RoomPos.z + 4.375)
			else:
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
