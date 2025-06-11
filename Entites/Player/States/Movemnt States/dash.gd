extends State

@export var RunState: State
@export var JumpState: State
@export var SlideState: State
@export var FallState: State
@export var IdleState: State

var timeout: bool

func dash_timeout():
	timeout = true

func enter() -> void:
	timeout = false
	var DashTimer = Timer.new()
	DashTimer.one_shot = true
	DashTimer.wait_time = 0.2
	DashTimer.timeout.connect(dash_timeout)
	add_child(DashTimer)
	DashTimer.start()
	parent.velocity.x = parent.InputDir.x * MoveSpeed * 2
	parent.velocity.z = parent.InputDir.z * MoveSpeed * 2

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
	
	if timeout:
		if parent.is_on_floor():
			return RunState
		return FallState
	
	if parent.is_on_floor():
		parent.Jumped = false
		if Input.is_action_pressed("jump"):
			return JumpState
	
	parent.move_and_slide()
	return null
