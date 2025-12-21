extends Node3D
class_name Wall

var pivot: Pivot
var player: Player
var child: MeshInstance3D

func _ready() -> void:
	var children = get_child(0)
	if children is MeshInstance3D:
		child = children
	
func _process(_delta: float) -> void:	
	var PlayerPos = player.global_position
	var CamPos = pivot.CamPos
	var ObjPos = global_position
	
	var PlayerDot = (PlayerPos).dot(CamPos.normalized())
	var CamDot = (CamPos).dot(CamPos.normalized())
	var ObjDot = (ObjPos).dot(CamPos.normalized())
	
	var PlayerLocal = (PlayerPos - pivot.global_position) * pivot.global_transform.basis
	var ObjLocal = (ObjPos - pivot.global_position) * pivot.global_transform.basis
	
	var Player2D = Vector2(PlayerLocal.x, PlayerLocal.y)
	var Obj2D = Vector2(ObjLocal.x, ObjLocal.y)
	
	var offset = Player2D.distance_to(Obj2D)
	var transparent = 1 - offset/2
	if (PlayerDot < ObjDot and ObjDot < CamDot) and ObjPos.y >= PlayerPos.y - 0.5:
		update_transparent(transparent)
	else:
		update_transparent(0)

func update_transparent(value: float) -> void:
	child.set_transparency(clamp(value, 0.0, 1.0))
