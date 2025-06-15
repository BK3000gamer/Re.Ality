extends Environments

var pivot: Pivot
var player: Player

func _process(delta: float) -> void:
	var PlayerPos = player.global_position
	var CamPos = pivot.CamPos
	var ObjPos = global_position
	
	if pivot.CurrentState == "SideNS":
		if (PlayerPos.x < ObjPos.x and ObjPos.x < CamPos.x) or (CamPos.x < ObjPos.x and ObjPos.x < PlayerPos.x):
			update_transparent(0)
		else:
			update_transparent(1)
	else:
		update_transparent(1)

func update_transparent(value: float) -> void:
	set_instance_shader_parameter("transparency", clamp(value, 0.0, 1.0))
