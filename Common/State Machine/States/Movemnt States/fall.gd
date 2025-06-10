extends State

@export var IdleState: State
@export var RunState: State
@export var CrouchState: State
@export var SlideState: State

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("crouch"):
		if parent.InputDir.x == 0 and parent.InputDir.z == 0:
			return CrouchState
		return SlideState
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
