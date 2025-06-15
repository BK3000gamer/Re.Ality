extends State

@export var SideNS: State
@export var TopWE: State

func enter() -> void:
	pivot.CurrentState = "SideWE"

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("rotate_right"):
		RotationControl._camera_right()
		pivot.IsInSideView = true
		return SideNS
	elif event.is_action_pressed("rotate_left"):
		RotationControl._camera_left()
		pivot.IsInSideView = true
		return SideNS	
	elif event.is_action_pressed("rotate_up_down"):
		RotationControl._camera_up()
		pivot.IsInSideView = false
		return TopWE
	return null
