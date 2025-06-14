extends Room

func _ready() -> void:
	RoomType = [2, 0, 0]
	init_pivot("Pivot")
	init_player("Player")
	
	for child in get_children():
		if child is Environments:
			child.pivot = pivot
			child.player = player
