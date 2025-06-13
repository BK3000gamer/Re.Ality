extends Room

func _ready() -> void:
	RoomType = [1, 0, 0]
	init_pivot("Pivot")
	init_player("Player")
	
	for child in get_children():
		if child is Wall:
			child.pivot = pivot
			child.player = player
