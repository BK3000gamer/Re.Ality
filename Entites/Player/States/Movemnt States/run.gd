extends State

@export var IdleState: State
@export var JumpState: State
@export var FallState: State
@export var SlideState: State
@export var DashState: State

func enter() -> void:
	parent.Jumped = false

func process_input(event: InputEvent) -> State:
	if pivot.IsInSideView:
		if event.is_action_pressed("jump") and parent.is_on_floor():
			return JumpState
	
	if event.is_action_pressed("crouch"):
		return SlideState
	
	if event.is_action_pressed("dash"):
		return DashState
	return null

func process_physics(delta: float) -> State:
	parent.InputDir = Vector3.ZERO
	
	if pivot.IsInSideView:
		parent.InputDir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		parent.InputDir = parent.InputDir.rotated(Vector3.UP, pivot.rotation.y).normalized()
	elif !pivot.IsInSideView:
		parent.InputDir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		parent.InputDir.z = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		parent.InputDir = parent.InputDir.rotated(Vector3.UP, pivot.rotation.y).normalized()
	
	parent.velocity.y += _get_gravity() * delta
	
	parent.velocity.x = parent.InputDir.x * MoveSpeed
	parent.velocity.z = parent.InputDir.z * MoveSpeed
	
	if parent.InputDir == Vector3.ZERO:
		return IdleState
	
	if !parent.is_on_floor():
		return FallState
	
	parent.move_and_slide()
	return null
