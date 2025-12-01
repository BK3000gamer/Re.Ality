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

func _process(_delta: float) -> void:
	MousePos = get_viewport().get_mouse_position()
	MouseDir = Vector3.ZERO
	
	var playerPos = Vector2(GetPlayer2dPosition.HorizontalPos, GetPlayer2dPosition.VerticalPos)
	
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
	
	if Input.is_action_pressed("look_ahead"):
		if player.CurrentState == "Idle":
			TargetPos = PlayerPos + MouseDir.normalized() * LookAheadDistance
			PivotPos.x = move_toward(PivotPos.x, TargetPos.x, 10 * delta)
			PivotPos.z = move_toward(PivotPos.z, TargetPos.z, 10 * delta)
		else:
			PivotPos.x = PlayerPos.x
			PivotPos.z = PlayerPos.z
		
	if Input.is_action_just_released("look_ahead"):
		PivotPos.x = PlayerPos.x
		PivotPos.z = PlayerPos.z
	
	PivotPos.y = player.RoomPos.y
	
	if abs(PlayerPos.x - PivotPos.x) > HorizontalDeadZone:
				TargetPos.x = PlayerPos.x
				PivotPos.x = move_toward(PivotPos.x, TargetPos.x, abs(FollowSpeed.x) * delta)
	
	if abs(PlayerPos.z - PivotPos.z) > HorizontalDeadZone:
				TargetPos.z = PlayerPos.z
				PivotPos.z = move_toward(PivotPos.z, TargetPos.z, abs(FollowSpeed.z) * delta)
	
	pivot.global_position = PivotPos
