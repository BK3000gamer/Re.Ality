extends Node

var pivot: Pivot
var player: Player

var PlayerPos
var PivotPos

var TargetPos

var HorizontalDeadZone = 1
var VerticalDeadZone = 1
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
	

func _physics_process(delta: float) -> void:
	PlayerPos = player.global_position
	PivotPos = pivot.global_position
	TargetPos = PivotPos
	FollowSpeed = player.velocity
	
	if player.CurrentState == "Super Jump":
		FollowSpeed = player.velocity * 2
	
	if pivot.RoomType.size() > 0:
		if pivot.RoomType[0] == 1:
			if abs(PlayerPos.x - PivotPos.x) > HorizontalDeadZone:
				TargetPos.x = PlayerPos.x
				PivotPos.x = move_toward(PivotPos.x, TargetPos.x, abs(FollowSpeed.x) * delta)
			
			if pivot.CurrentState == "TopNS":
				if PivotPos.x < (pivot.RoomPos.x - 4.375):
					PivotPos.x = (pivot.RoomPos.x - 4.375)
					TargetPos.x = (pivot.RoomPos.x - 4.375)
			else:
				if PivotPos.x < pivot.RoomPos.x:
					PivotPos.x = pivot.RoomPos.x
					TargetPos.x = pivot.RoomPos.x
		
		if pivot.RoomType[0] == -1:
			if abs(PlayerPos.x - PivotPos.x) > HorizontalDeadZone:
				TargetPos.x = PlayerPos.x
				PivotPos.x = move_toward(PivotPos.x, TargetPos.x, abs(FollowSpeed.x) * delta)
			
			if pivot.CurrentState == "TopNS":
				if PivotPos.x > (pivot.RoomPos.x + 4.375):
					PivotPos.x = (pivot.RoomPos.x + 4.375)
					TargetPos.x = (pivot.RoomPos.x + 4.375)
			else:
				if PivotPos.x > pivot.RoomPos.x:
					PivotPos.x = pivot.RoomPos.x
					TargetPos.x = pivot.RoomPos.x
		
		if pivot.RoomType[0] == 2:
			if abs(PlayerPos.x - PivotPos.x) > HorizontalDeadZone:
				TargetPos.x = PlayerPos.x
				PivotPos.x = move_toward(PivotPos.x, TargetPos.x, abs(FollowSpeed.x) * delta)
		
		if pivot.RoomType[0] == 0:
			if abs(PlayerPos.x - PivotPos.x) > HorizontalDeadZone:
				TargetPos.x = PlayerPos.x
				PivotPos.x = move_toward(PivotPos.x, TargetPos.x, abs(FollowSpeed.x) * delta)
			
			if pivot.CurrentState == "TopNS":
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
			if abs(PlayerPos.z - PivotPos.z) > HorizontalDeadZone:
				TargetPos.z = PlayerPos.z
				PivotPos.z = move_toward(PivotPos.z, TargetPos.z, abs(FollowSpeed.z) * delta)
			
			if pivot.CurrentState == "TopWE":
				if PivotPos.z < (pivot.RoomPos.z - 4.375):
					PivotPos.z = (pivot.RoomPos.z - 4.375)
					TargetPos.z = (pivot.RoomPos.z - 4.375)
			else:
				if PivotPos.z < pivot.RoomPos.z:
					PivotPos.z = pivot.RoomPos.z
					TargetPos.z = pivot.RoomPos.z
		
		if pivot.RoomType[2] == -1:
			if abs(PlayerPos.z - PivotPos.z) > HorizontalDeadZone:
				TargetPos.z = PlayerPos.z
				PivotPos.z = move_toward(PivotPos.z, TargetPos.z, abs(FollowSpeed.z) * delta)
			
			if pivot.CurrentState == "TopWE":
				if PivotPos.z > (pivot.RoomPos.z + 4.375):
					PivotPos.z = (pivot.RoomPos.z + 4.375)
					TargetPos.z = (pivot.RoomPos.z + 4.375)
			else:
				if PivotPos.z > pivot.RoomPos.z:
					PivotPos.z = pivot.RoomPos.z
					TargetPos.z = pivot.RoomPos.z
		
		if pivot.RoomType[2] == 2:
			if abs(PlayerPos.z - PivotPos.z) > HorizontalDeadZone:
				TargetPos.z = PlayerPos.z
				PivotPos.z = move_toward(PivotPos.z, TargetPos.z, abs(FollowSpeed.z) * delta)
		
		if pivot.RoomType[2] == 0:
			if abs(PlayerPos.z - PivotPos.z) > HorizontalDeadZone:
				TargetPos.z = PlayerPos.z
				PivotPos.z = move_toward(PivotPos.z, TargetPos.z, abs(FollowSpeed.z) * delta)
			
			if pivot.CurrentState == "TopWE":
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
			if abs(PlayerPos.y - PivotPos.y) > HorizontalDeadZone:
				TargetPos.y = PlayerPos.y
				PivotPos.y = move_toward(PivotPos.y, TargetPos.y, abs(FollowSpeed.y) * delta)
			if PivotPos.y < pivot.RoomPos.y:
					PivotPos.y = pivot.RoomPos.y
					TargetPos.y = pivot.RoomPos.y
		
		if pivot.RoomType[1] == -1:
			if abs(PlayerPos.y - PivotPos.y) > HorizontalDeadZone:
				TargetPos.y = PlayerPos.y
				PivotPos.y = move_toward(PivotPos.y, TargetPos.y, abs(FollowSpeed.y) * delta)
			if PivotPos.y > pivot.RoomPos.y:
					PivotPos.y = pivot.RoomPos.y
					TargetPos.y = pivot.RoomPos.y
		
		if pivot.RoomType[1] == 2:
			if abs(PlayerPos.y - PivotPos.y) > HorizontalDeadZone:
				TargetPos.y = PlayerPos.y
				PivotPos.y = move_toward(PivotPos.y, TargetPos.y, abs(FollowSpeed.y) * delta)
		
		if pivot.RoomType[1] == 0:
			if abs(PlayerPos.y - PivotPos.y) > HorizontalDeadZone:
				TargetPos.y = PlayerPos.y
				PivotPos.y = move_toward(PivotPos.y, TargetPos.y, abs(FollowSpeed.y) * delta)
			if PivotPos.y < pivot.RoomPos.y:
					PivotPos.y = pivot.RoomPos.y
					TargetPos.y = pivot.RoomPos.y
			elif PivotPos.y > pivot.RoomPos.y:
					PivotPos.y = pivot.RoomPos.y
					TargetPos.y = pivot.RoomPos.y
	
	
	
	pivot.global_position = PivotPos
