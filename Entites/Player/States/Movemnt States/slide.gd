extends State

@export var IdleState: State
@export var RunState: State
@export var FallState: State
@export var CrouchState: State
@export var DashState: State
@export var SuperJumpState: State

var decay = 15

func enter() -> void:
	parent.velocity.x = parent.InputDir.x * MoveSpeed * 1.5
	parent.velocity.z = parent.InputDir.z * MoveSpeed * 1.5

func process_input(event: InputEvent) -> State:
	if !parent.InputDir == Vector3.ZERO and event.is_action_pressed("dash"):
			return DashState
	
	if event.is_action_pressed("jump"):
		return SuperJumpState
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += _get_gravity() * delta
	
	parent.InputDir = Vector3.ZERO
	
	var horizontal_velocity = Vector3(parent.velocity.x, 0, parent.velocity.z)
	var speed = horizontal_velocity.length()	
	
	if pivot.IsInSideView:
		parent.InputDir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		parent.InputDir = parent.InputDir.rotated(Vector3.UP, pivot.rotation.y).normalized()
	elif !pivot.IsInSideView:
		parent.InputDir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		parent.InputDir.z = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		parent.InputDir = parent.InputDir.rotated(Vector3.UP, pivot.rotation.y).normalized()
	
	if speed > 0:
		var decay_amount = decay * delta
		speed = max(speed - decay_amount, 0)
		horizontal_velocity = horizontal_velocity.normalized() * speed
		
		parent.velocity.x = horizontal_velocity.x
		parent.velocity.z = horizontal_velocity.z
		
		if speed == 0:
			if !parent.is_on_floor():
				return FallState
			return CrouchState
	
	if parent.is_on_floor():
		parent.Jumped = false
		if !Input.is_action_pressed("crouch"):
			if parent.InputDir == Vector3.ZERO:
				return IdleState
			return RunState
	
	parent.move_and_slide()
	return null
