extends State

@export var IdleState: State
@export var RunState: State

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += _get_gravity() * delta
	
	if pivot.IsInSideView:
		parent.InputDir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		parent.InputDir = parent.InputDir.rotated(Vector3.UP, pivot.rotation.y)
	elif !pivot.IsInSideView:
		parent.InputDir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		parent.InputDir.z = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		parent.InputDir = parent.InputDir.rotated(Vector3.UP, pivot.rotation.y)
	
	parent.velocity.x = parent.InputDir.x * MoveSpeed
	parent.velocity.z = parent.InputDir.z * MoveSpeed
	
	if parent.is_on_floor():
		if pivot.IsInSideView:
			if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
				return RunState
			return IdleState
		elif !pivot.IsInSideView:
			if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down"):
				return RunState
			return IdleState
	
	parent.move_and_slide()
	return null
