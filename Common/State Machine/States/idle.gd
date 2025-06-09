extends State

@export var RunState: State
@export var JumpState: State
@export var FallState: State

func enter() -> void:
	parent.velocity.x = 0
	parent.velocity.z = 0

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += _get_gravity() * delta
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return FallState
	return null
