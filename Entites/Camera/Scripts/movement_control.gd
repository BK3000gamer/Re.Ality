extends Node

var pivot: Pivot
var player: Player

var PlayerPos
var PivotPos

var TargetPos

var HorizontalDeadZone = 2
var VerticalDeadZone = 2
var FollowSpeed

func init(Parent: Pivot) -> void:
	pivot = Parent

func init_sibling(PlayerName: String) -> void:
	var grandparent = get_parent().get_parent()
	if grandparent == null:
		return
	
	var SiblingPlayer = grandparent.get_node_or_null(PlayerName)
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
			if pivot.position.x < pivot.RoomPos.x:
				pivot.position.x = pivot.RoomPos.x
				TargetPos.x = pivot.RoomPos.x
		
		if pivot.RoomType[0] == -1:
			if abs(PlayerPos.x - PivotPos.x) > HorizontalDeadZone:
				TargetPos.x = PlayerPos.x
				pivot.global_position.x = move_toward(pivot.global_position.x, TargetPos.x, abs(FollowSpeed.x) * delta)
			if pivot.position.x > pivot.RoomPos.x:
				pivot.position.x = pivot.RoomPos.x
				TargetPos.x = pivot.RoomPos.x
		
		if pivot.RoomType[0] == 2:
			if abs(PlayerPos.x - PivotPos.x) > HorizontalDeadZone:
				TargetPos.x = PlayerPos.x
				pivot.global_position.x = move_toward(pivot.global_position.x, TargetPos.x, abs(FollowSpeed.x) * delta)
