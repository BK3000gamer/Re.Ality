extends State

@export var FallState: State
@export var RunState: State
@export var IdleState: State
@export var CrouchState: State
@export var SlideState: State

func enter() -> void:
	parent.velocity.y = JumpVelocity

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("crouch"):
		if parent.InputDir.x == 0:
			return CrouchState
		return SlideState
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += _get_gravity() * delta
	
	parent.InputDir = Vector3.ZERO
	
	parent.InputDir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	parent.InputDir = parent.InputDir.rotated(Vector3.UP, pivot.rotation.y).normalized()
	parent.velocity.x = parent.InputDir.x * MoveSpeed
	
	if parent.velocity.y < 0:
		return FallState
		
	if parent.is_on_floor():
		if parent.InputDir.x == 0:
			return IdleState
		return RunState
	
	parent.move_and_slide()
	return null
