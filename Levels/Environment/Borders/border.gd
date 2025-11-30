extends Environments
class_name Border

var pivot: Pivot
var player: Player

func update_transparent(value: float) -> void:
	set_transparency(clamp(value, 0.0, 1.0))
