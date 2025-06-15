extends State

@export var SideWE: State
@export var TopNS: State

func enter() -> void:
	pivot.CurrentState = "TopWE"

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("rotate_right"):
		RotationControl._camera_right()
		pivot.IsInSideView = false
		return TopNS
	elif event.is_action_pressed("rotate_left"):
		RotationControl._camera_left()
		pivot.IsInSideView = false
		return TopNS	
	elif event.is_action_pressed("rotate_up_down"):
		RotationControl._camera_down()
		pivot.IsInSideView = true
		return SideWE
	return null
