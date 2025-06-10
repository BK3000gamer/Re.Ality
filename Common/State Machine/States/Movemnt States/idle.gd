extends State

@export var RunState: State
@export var JumpState: State
@export var FallState: State

func enter() -> void:
	parent.velocity.x = 0
	parent.velocity.z = 0

func process_input(event: InputEvent) -> State:
	if pivot.IsInSideView:
		if event.is_action_pressed("move_left") or event.is_action_pressed("move_right"):
			return RunState
		elif event.is_action_pressed("jump") and parent.is_on_floor():
			return JumpState
	elif !pivot.IsInSideView:
		if event.is_action_pressed("move_left") or event.is_action_pressed("move_right") or event.is_action_pressed("move_up") or event.is_action_pressed("move_down"):
			return RunState
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += _get_gravity() * delta
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return FallState
	return null
