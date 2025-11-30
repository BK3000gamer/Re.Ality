extends Area3D
class_name Room

var pivot: Pivot
var player: Player

func init_pivot(SiblingName: String) -> void:
	var parent = get_parent()
	var Sibling = parent.get_node_or_null(SiblingName)
	if Sibling == null:
		push_error("Pivot not found: " + SiblingName)
		return
	
	pivot = Sibling

func init_player(SiblingName: String) -> void:
	var parent = get_parent()
	var Sibling = parent.get_node_or_null(SiblingName)
	if Sibling == null:
		push_error("Player not found: " + SiblingName)
		return
	
	player = Sibling
