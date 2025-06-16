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
	var grandparent = get_parent().get_parent().get_parent()
	
	var subview = grandparent.get_node("Entity")
	
	var SiblingPlayer = subview.get_node_or_null(PlayerName)
	if SiblingPlayer == null:
		push_warning("Player node not found.")
		return
	
	player = SiblingPlayer
	

func _physics_process(delta: float) -> void:
	PlayerPos = player.global_position
	PivotPos = pivot.global_position
	TargetPos = PivotPos
	FollowSpeed = player.velocity
	if pivot.RoomType.size() > 0:
		if pivot.RoomType[0] == 1:
			if abs(PlayerPos.x - PivotPos.x) > HorizontalDeadZone:
				TargetPos.x = PlayerPos.x
				pivot.global_position.x = move_toward(pivot.global_position.x, TargetPos.x, abs(FollowSpeed.x) * delta)
			
			if pivot.CurrentState == "TopNS":
				if pivot.position.x < (pivot.RoomPos.x - 4.375):
					pivot.position.x = (pivot.RoomPos.x - 4.375)
					TargetPos.x = (pivot.RoomPos.x - 4.375)
			else:
				if pivot.position.x < pivot.RoomPos.x:
					pivot.position.x = pivot.RoomPos.x
					TargetPos.x = pivot.RoomPos.x
		
		if pivot.RoomType[0] == -1:
			if abs(PlayerPos.x - PivotPos.x) > HorizontalDeadZone:
				TargetPos.x = PlayerPos.x
				pivot.global_position.x = move_toward(pivot.global_position.x, TargetPos.x, abs(FollowSpeed.x) * delta)
			
			if pivot.CurrentState == "TopNS":
				if pivot.position.x > (pivot.RoomPos.x + 4.375):
					pivot.position.x = (pivot.RoomPos.x + 4.375)
					TargetPos.x = (pivot.RoomPos.x + 4.375)
			else:
				if pivot.position.x > pivot.RoomPos.x:
					pivot.position.x = pivot.RoomPos.x
					TargetPos.x = pivot.RoomPos.x
		
		if pivot.RoomType[0] == 2:
			if abs(PlayerPos.x - PivotPos.x) > HorizontalDeadZone:
				TargetPos.x = PlayerPos.x
				pivot.global_position.x = move_toward(pivot.global_position.x, TargetPos.x, abs(FollowSpeed.x) * delta)
		
		if pivot.RoomType[0] == 0:
			if abs(PlayerPos.x - PivotPos.x) > HorizontalDeadZone:
				TargetPos.x = PlayerPos.x
				pivot.global_position.x = move_toward(pivot.global_position.x, TargetPos.x, abs(FollowSpeed.x) * delta)
			
			if pivot.CurrentState == "TopNS":
				if pivot.position.x < (pivot.RoomPos.x - 4.375):
					pivot.position.x = (pivot.RoomPos.x - 4.375)
					TargetPos.x = (pivot.RoomPos.x - 4.375)
				elif pivot.position.x > (pivot.RoomPos.x + 4.375):
					pivot.position.x = (pivot.RoomPos.x + 4.375)
					TargetPos.x = (pivot.RoomPos.x + 4.375)
			else:
				if pivot.position.x > pivot.RoomPos.x:
					pivot.position.x = pivot.RoomPos.x
					TargetPos.x = pivot.RoomPos.x
				elif pivot.position.x < pivot.RoomPos.x:
					pivot.position.x = pivot.RoomPos.x
					TargetPos.x = pivot.RoomPos.x
		
		if pivot.RoomType[2] == 1:
			if abs(PlayerPos.z - PivotPos.z) > HorizontalDeadZone:
				TargetPos.z = PlayerPos.z
				pivot.global_position.z = move_toward(pivot.global_position.z, TargetPos.z, abs(FollowSpeed.z) * delta)
			
			if pivot.CurrentState == "TopWE":
				if pivot.position.z < (pivot.RoomPos.z - 4.375):
					pivot.position.z = (pivot.RoomPos.z - 4.375)
					TargetPos.z = (pivot.RoomPos.z - 4.375)
			else:
				if pivot.position.z < pivot.RoomPos.z:
					pivot.position.z = pivot.RoomPos.z
					TargetPos.z = pivot.RoomPos.z
		
		if pivot.RoomType[2] == -1:
			if abs(PlayerPos.z - PivotPos.z) > HorizontalDeadZone:
				TargetPos.z = PlayerPos.z
				pivot.global_position.z = move_toward(pivot.global_position.z, TargetPos.z, abs(FollowSpeed.z) * delta)
			
			if pivot.CurrentState == "TopWE":
				if pivot.position.z > (pivot.RoomPos.z + 4.375):
					pivot.position.z = (pivot.RoomPos.z + 4.375)
					TargetPos.z = (pivot.RoomPos.z + 4.375)
			else:
				if pivot.position.z > pivot.RoomPos.z:
					pivot.position.z = pivot.RoomPos.z
					TargetPos.z = pivot.RoomPos.z
		
		if pivot.RoomType[2] == 2:
			if abs(PlayerPos.z - PivotPos.z) > HorizontalDeadZone:
				TargetPos.z = PlayerPos.z
				pivot.global_position.z = move_toward(pivot.global_position.z, TargetPos.z, abs(FollowSpeed.z) * delta)
		
		if pivot.RoomType[2] == 0:
			if abs(PlayerPos.z - PivotPos.z) > HorizontalDeadZone:
				TargetPos.z = PlayerPos.z
				pivot.global_position.z = move_toward(pivot.global_position.z, TargetPos.z, abs(FollowSpeed.z) * delta)
			
			if pivot.CurrentState == "TopWE":
				if pivot.position.z < (pivot.RoomPos.z - 4.375):
					pivot.position.z = (pivot.RoomPos.z - 4.375)
					TargetPos.z = (pivot.RoomPos.z - 4.375)
				elif pivot.position.z > (pivot.RoomPos.z + 4.375):
					pivot.position.z = (pivot.RoomPos.z + 4.375)
					TargetPos.z = (pivot.RoomPos.z + 4.375)
			else:
				if pivot.position.z > pivot.RoomPos.z:
					pivot.position.z = pivot.RoomPos.z
					TargetPos.z = pivot.RoomPos.z
				elif pivot.position.z < pivot.RoomPos.z:
					pivot.position.z = pivot.RoomPos.z
					TargetPos.z = pivot.RoomPos.z
		
		if pivot.RoomType[1] == 1:
			if abs(PlayerPos.y - PivotPos.y) > HorizontalDeadZone:
				TargetPos.y = PlayerPos.y
				pivot.global_position.y = move_toward(pivot.global_position.y, TargetPos.y, abs(FollowSpeed.y) * delta)
			if pivot.position.y < pivot.RoomPos.y:
					pivot.position.y = pivot.RoomPos.y
					TargetPos.y = pivot.RoomPos.y
		
		if pivot.RoomType[1] == -1:
			if abs(PlayerPos.y - PivotPos.y) > HorizontalDeadZone:
				TargetPos.y = PlayerPos.y
				pivot.global_position.y = move_toward(pivot.global_position.y, TargetPos.y, abs(FollowSpeed.y) * delta)
			if pivot.position.y > pivot.RoomPos.y:
					pivot.position.y = pivot.RoomPos.y
					TargetPos.y = pivot.RoomPos.y
		
		if pivot.RoomType[1] == 2:
			if abs(PlayerPos.y - PivotPos.y) > HorizontalDeadZone:
				TargetPos.y = PlayerPos.y
				pivot.global_position.y = move_toward(pivot.global_position.y, TargetPos.y, abs(FollowSpeed.y) * delta)
		
		if pivot.RoomType[1] == 0:
			if abs(PlayerPos.y - PivotPos.y) > HorizontalDeadZone:
				TargetPos.y = PlayerPos.y
				pivot.global_position.y = move_toward(pivot.global_position.y, TargetPos.y, abs(FollowSpeed.y) * delta)
			if pivot.position.y < pivot.RoomPos.y:
					pivot.position.y = pivot.RoomPos.y
					TargetPos.y = pivot.RoomPos.y
			elif pivot.position.y > pivot.RoomPos.y:
					pivot.position.y = pivot.RoomPos.y
					TargetPos.y = pivot.RoomPos.y
