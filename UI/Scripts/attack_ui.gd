extends Node2D

func init_player(playerName: String) -> void:
	var parent = get_parent()
	
	var sibling = parent.get_node_or_null(playerName)
	
	for child in get_children():
		if sibling is Player:
			child.player = sibling

func  init_pivot(pivotName: String) -> void:
	var parent = get_parent()
	
	var sibling = parent.get_node_or_null(pivotName)
	
	for child in get_children():
		if sibling is Pivot:
			child.pivot = sibling

func _ready() -> void:
	init_player("Player")
	init_pivot("Pivot")
