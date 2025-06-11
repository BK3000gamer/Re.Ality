extends State

@export var FallState: State
@export var RunState: State
@export var IdleState: State
@export var CrouchState: State
@export var SlideState: State
@export var DashState: State
@export var DoubleJumpState: State

var JumpDistance = 20

var timeout: bool

func jump_timeout():
	timeout = true

func enter() -> void:
	timeout = false
	var JumpTimer = Timer.new()
	JumpTimer.one_shot = true
	JumpTimer.wait_time = 0.5
	JumpTimer.timeout.connect(jump_timeout)
	add_child(JumpTimer)
	JumpTimer.start()
	
	if pivot.IsInSideView:
		if parent.InputDir == Vector3.ZERO:
			parent.velocity.y = JumpDistance
		else:
			parent.velocity.x = parent.InputDir.x * JumpDistance
			parent.velocity.z = parent.InputDir.z * JumpDistance
			parent.velocity.y = 12
	else:
		if !parent.InputDir == Vector3.ZERO:
			parent.velocity.x = parent.InputDir.x * JumpDistance
			parent.velocity.z = parent.InputDir.z * JumpDistance
			parent.velocity.y = 12

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("crouch"):
		if parent.InputDir.x == 0:
			return CrouchState
		return SlideState
	
	if !parent.InputDir == Vector3.ZERO and event.is_action_pressed("dash"):
			return DashState
	
	if event.is_action_pressed("jump") and !parent.is_on_floor() and !parent.Jumped:
		return DoubleJumpState
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
	
	if timeout:
		if parent.velocity.y < 0:
			return FallState
			
		if parent.is_on_floor():
			if parent.InputDir.x == 0:
				return IdleState
			return RunState
	
	parent.move_and_slide()
	return null
