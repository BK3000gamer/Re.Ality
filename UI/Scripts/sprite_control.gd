extends Node2D

var player: Player
var pivot: Pivot

func init_player(PlayerName: String) -> void:
	var greatGreatGrandParent = get_parent().get_parent().get_parent().get_parent()
	
	var sibling = greatGreatGrandParent.get_node_or_null(PlayerName)
	if sibling is Player:
		player = sibling

func init_pivot() -> void:
	var greatGrandParent = get_parent().get_parent().get_parent()
	if greatGrandParent is Pivot:
		pivot = greatGrandParent

func _ready() -> void:
	init_player("Player")
	init_pivot()
