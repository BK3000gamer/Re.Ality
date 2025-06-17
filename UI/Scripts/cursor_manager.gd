extends CanvasLayer

@export var emptyCursor :Texture

func _ready() -> void:
	Input.set_custom_mouse_cursor(emptyCursor, Input.CURSOR_ARROW)

func _process(delta: float) -> void:
	$Sprite2D.global_position = $Sprite2D.get_global_mouse_position()
