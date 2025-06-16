extends Area3D
class_name Room

var RoomType:Array[int] = []
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
	var grandParent = get_parent().get_parent()
	var subview = grandParent.get_node("Entity")
	var Sibling = subview.get_node_or_null(SiblingName)
	if Sibling == null:
		push_error("Pivot not found: " + SiblingName)
		return
	
	player = Sibling
