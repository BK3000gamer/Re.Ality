extends Node

var subViewport: SubViewportContainer
var pivotMovementControl: Node

func _ready() -> void:
	subViewport = get_node("/root/main/SubViewportContainer")
	pivotMovementControl = get_node("/root/main/SubViewportContainer/SubViewport/Pivot/Movement Control")

func _process(_delta: float) -> void:
	subViewport.material.set_shader_parameter("cam_offset", pivotMovementControl.camSubpixelOffset)
