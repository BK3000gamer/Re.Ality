extends State

@export var RunState: State
@export var JumpState: State
@export var SlideState: State
@export var FallState: State
@export var IdleState: State
@export var WallSlideState: State

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
	MovementControl.dash()

func process_physics(delta: float) -> State:
	if timeout:
		if parent.is_on_floor():
			return RunState
		return FallState
	
	if parent.is_on_wall() and !parent.InputDir == Vector3.ZERO and !parent.WallSlided:
		return WallSlideState
	
	if parent.is_on_floor():
		parent.Jumped = false
		parent.SuperJumped = false
		parent.WallSlided = false
		if Input.is_action_pressed("jump"):
			return JumpState
	return null
