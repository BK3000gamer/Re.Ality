extends State

@export var IdleState: State
@export var JumpState: State
@export var FallState: State


func process_input(event: InputEvent) -> State:
	if pivot.IsInSideView:
		if event.is_action_pressed("jump") and parent.is_on_floor():
			return JumpState
	return null

func process_physics(delta: float) -> State:
	if pivot.IsInSideView:
		parent.InputDir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		parent.InputDir = parent.InputDir.rotated(Vector3.UP, pivot.rotation.y)
	elif !pivot.IsInSideView:
		parent.InputDir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		parent.InputDir.z = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		parent.InputDir = parent.InputDir.rotated(Vector3.UP, pivot.rotation.y)
	
	parent.velocity.y += _get_gravity() * delta
	
	parent.velocity.x = parent.InputDir.x * MoveSpeed
	parent.velocity.z = parent.InputDir.z * MoveSpeed
	
	if parent.InputDir.x == 0 and parent.InputDir.z == 0:
		return IdleState
	
	if !parent.is_on_floor():
		return FallState
	
	parent.move_and_slide()
	return null
