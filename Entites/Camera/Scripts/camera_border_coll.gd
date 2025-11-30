extends RayCast3D

func _process(_delta: float) -> void:
	if is_colliding():
		var collider = get_collider()
		if collider is Border:
			collider.update_transparent(1)
