extends Environments
class_name Wall

var pivot: Pivot
var player: Player
var transparent: float
	
func _process(delta: float) -> void:	
	var PlayerPos = player.global_position
	var CamPos = pivot.CamPos
	var ObjPos = global_position
	
	var PlayerPosRot = (PlayerPos).dot(CamPos.normalized())
	var CamPosRot = (CamPos).dot(CamPos.normalized())
	var ObjPosRot = (ObjPos).dot(CamPos.normalized())
	
	if pivot.CurrentState == "SideZ":
		if (PlayerPos.x < ObjPos.x and ObjPos.x < CamPos.x) or (CamPos.x < ObjPos.x and ObjPos.x < PlayerPos.x):
			transparent = abs(abs(PlayerPos.x - ObjPos.x) / 16 - 1)
			
			update_transparent(transparent)
		else:
			update_transparent(1)
	elif pivot.CurrentState == "SideXZ" or pivot.CurrentState == "SideZX" or pivot.CurrentView == "Middle":
		if (PlayerPosRot < ObjPosRot and ObjPosRot < CamPosRot) or (CamPosRot < ObjPosRot and ObjPosRot < PlayerPosRot):
			transparent = abs(abs(PlayerPosRot - ObjPosRot) / 16 - 1)
			
			update_transparent(transparent)
		else:
			update_transparent(1)
	elif pivot.CurrentState == "SideX":
		if (PlayerPos.z < ObjPos.z and ObjPos.z < CamPos.z) or (CamPos.z < ObjPos.z and ObjPos.z < PlayerPos.z):
			transparent = abs(abs(PlayerPos.z - ObjPos.z) / 16 - 1)
			if transparent > 0.94:
				transparent = 1
			
			update_transparent(transparent)
		else:
			update_transparent(1)
	elif pivot.CurrentView == "Top":
		if (PlayerPos.y < ObjPos.y and ObjPos.y < CamPos.y) or (CamPos.y < ObjPos.y and ObjPos.y < PlayerPos.y):
			transparent = abs(abs(PlayerPos.y - ObjPos.y) / 16 - 1)
			if transparent > 0.94:
				transparent = 1
			
			update_transparent(transparent)
		else:
			update_transparent(1)
	else:
		update_transparent(1)

func update_transparent(value: float) -> void:
	set_instance_shader_parameter("transparency", clamp(value, 0.0, 1.0))
