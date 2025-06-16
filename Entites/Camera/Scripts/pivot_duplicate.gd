extends Node3D

var pivot: Pivot

func init() -> void:
	var grandParent = get_parent().get_parent()
	
	var sibling = grandParent.get_node("Environment/Pivot")
	if sibling is Pivot:
		pivot = sibling

func _ready() -> void:
	init()

func _process(_delta) -> void:
	transform = pivot.transform
