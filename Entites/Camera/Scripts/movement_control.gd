extends Node3D

var pivot: Pivot
var player: Player

func init(Parent: Pivot) -> void:
	pivot = Parent

func init_sibling(PlayerName: String) -> void:
	var grandparent = get_parent().get_parent()
	if grandparent == null:
		return
	
	var SiblingPlayer = grandparent.get_node_or_null(PlayerName)
	if SiblingPlayer == null:
		push_warning("Player node not found.")
		return
	
	player = SiblingPlayer

func _physics_process(delta: float) -> void:
	if pivot.RoomType.size() > 0:
		if pivot.RoomType[0] == 1:
			pivot.position.x = player.position.x
			if pivot.position.x < pivot.RoomPos.x:
				pivot.position.x = pivot.RoomPos.x
