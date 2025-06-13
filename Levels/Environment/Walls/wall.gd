extends Environments
class_name Wall

var pivot: Pivot
var player: Player
	
func _process(delta: float) -> void:	
	var PlayerPos = player.global_position
	var CamPos = pivot.CamPos
	var ObjPos = global_position
	
	if pivot.CurrentState == "SideNS":
		if (PlayerPos.x < ObjPos.x and ObjPos.x < CamPos.x) or (CamPos.x < ObjPos.x and ObjPos.x < PlayerPos.x):
			update_transparency(abs(PlayerPos.x - ObjPos.x) / 10)
		else:
			update_transparency(1)
	elif pivot.CurrentState == "SideWE":
		if (PlayerPos.z < ObjPos.z and ObjPos.z < CamPos.z) or (CamPos.z < ObjPos.z and ObjPos.z < PlayerPos.z):
			update_transparency(abs(PlayerPos.z - ObjPos.z) / 10)
		else:
			update_transparency(1)

func update_transparency(value: float) -> void:
	set_instance_shader_parameter("transparency", clamp(value, 0.0, 1.0))
