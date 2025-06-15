extends State

@export var IdleState: State
@export var RunState: State
@export var FallState: State
@export var DashState: State
@export var SuperJumpState: State

var timeout: bool

func crouch_timeout():
	timeout = true

func enter() -> void:
	timeout = false
	var CrouchTimer = Timer.new()
	CrouchTimer.one_shot = true
	CrouchTimer.wait_time = 0.5
	CrouchTimer.timeout.connect(crouch_timeout)
	add_child(CrouchTimer)
	CrouchTimer.start()

func process_input(event: InputEvent) -> State:
	if !parent.InputDir == Vector3.ZERO and event.is_action_pressed("dash"):
			return DashState
	
	if event.is_action_pressed("jump"):
		return SuperJumpState
	return null

func process_physics(delta: float) -> State:
	if parent.is_on_floor():
		parent.Jumped = false
		if !Input.is_action_pressed("crouch"):
			if parent.InputDir == Vector3.ZERO:
				return IdleState
			return RunState
	
	if !parent.is_on_floor() and timeout:
		return FallState
	return null
