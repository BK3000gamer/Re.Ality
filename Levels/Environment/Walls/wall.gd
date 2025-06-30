extends Environments
class_name Wall

var pivot: Pivot
var player: Player
var transparent: float
	
func _process(delta: float) -> void:	
	var PlayerPos = player.global_position
	var CamPos = pivot.CamPos
	var ObjPos = global_position
	
	if pivot.CurrentState == "SideNS":
		if (PlayerPos.x < ObjPos.x and ObjPos.x < CamPos.x) or (CamPos.x < ObjPos.x and ObjPos.x < PlayerPos.x):
			transparent = abs(abs(PlayerPos.x - ObjPos.x) / 16 - 1)
			
			update_transparent(transparent)
		else:
			update_transparent(1)
	elif pivot.CurrentState == "SideWE":
		if (PlayerPos.z < ObjPos.z and ObjPos.z < CamPos.z) or (CamPos.z < ObjPos.z and ObjPos.z < PlayerPos.z):
			transparent = abs(abs(PlayerPos.z - ObjPos.z) / 16 - 1)
			if transparent > 0.8:
				transparent = 1
			
			update_transparent(transparent)
		else:
			update_transparent(1)
	else:
		update_transparent(1)

func update_transparent(value: float) -> void:
	set_instance_shader_parameter("transparency", clamp(value, 0.0, 1.0))
