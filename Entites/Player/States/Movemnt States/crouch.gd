extends State

@export var IdleState: State
@export var RunState: State
@export var FallState: State
@export var DashState: State

func process_input(event: InputEvent) -> State:
	if !parent.InputDir == Vector3.ZERO:
		if event.is_action_pressed("dash"):
			return DashState
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += _get_gravity() * delta
	
	parent.InputDir = Vector3.ZERO
	
	if pivot.IsInSideView:
		parent.InputDir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		parent.InputDir = parent.InputDir.rotated(Vector3.UP, pivot.rotation.y).normalized()
	elif !pivot.IsInSideView:
		parent.InputDir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		parent.InputDir.z = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		parent.InputDir = parent.InputDir.rotated(Vector3.UP, pivot.rotation.y).normalized()
	
	parent.velocity.x = parent.InputDir.x * MoveSpeed * 0.3
	parent.velocity.z = parent.InputDir.z * MoveSpeed * 0.3
	
	if parent.is_on_floor():
		if !Input.is_action_pressed("crouch"):
			if parent.InputDir == Vector3.ZERO:
				return IdleState
			return RunState
	else:
		return FallState
	parent.move_and_slide()
	return null
