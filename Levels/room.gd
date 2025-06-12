extends Area3D
class_name Room

var RoomType:Array[int] = []
var RoomPos

func _physics_process(delta: float) -> void:
	RoomPos = global_position
