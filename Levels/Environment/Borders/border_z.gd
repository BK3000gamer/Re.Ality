extends Environments

var pivot: Pivot
var player: Player

func _process(delta: float) -> void:
	var PlayerPos = player.global_position
	var CamPos = pivot.CamPos
	var ObjPos = global_position
	
	if pivot.CurrentState == "SideWE":
		if (PlayerPos.z < ObjPos.z and ObjPos.z < CamPos.z) or (CamPos.z < ObjPos.z and ObjPos.z < PlayerPos.z):
			update_transparent(0)
		else:
			update_transparent(1)
	else:
		update_transparent(1)

func update_transparent(value: float) -> void:
	set_instance_shader_parameter("transparency", clamp(value, 0.0, 1.0))
