extends State

@export_category("Connected States")
@export var RunState: State
@export var JumpState: State
@export var SlideState: State
@export var CrouchState: State
@export var FallState: State
@export var IdleState: State
@export var WallSlideState: State

var dashTimeout: bool
var timeout: bool

func dash_timeout():
	parent.velocity = Vector3.ZERO
	dashTimeout = true

func time_timeout():
	timeout = true

func enter() -> void:
	parent.PreviousState = parent.CurrentState
	parent.CurrentState = "Dash"
	dashTimeout = false
	var DashTimer = Timer.new()
	DashTimer.one_shot = true
	DashTimer.wait_time = 0.2
	DashTimer.timeout.connect(dash_timeout)
	add_child(DashTimer)
	DashTimer.start()
	timeout = false
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 0.3
	timer.timeout.connect(time_timeout)
	add_child(timer)
	timer.start()
	MovementControl.dash()

func process_physics(_delta: float) -> State:
	if timeout:
		if parent.is_on_floor():
			return RunState
		return FallState
	
	if parent.is_on_wall() and !parent.is_on_floor() and !parent.InputDir == Vector3.ZERO:
		return WallSlideState
		
	if Input.is_action_pressed("crouch"):
		if parent.InputDir.x == 0 or  parent.InputDir.z == 0:
			return CrouchState
		return SlideState
	
	if parent.is_on_floor():
		parent.Jumped = false
		parent.SuperJumped = false
		if Input.is_action_pressed("jump"):
			return JumpState
	return null
