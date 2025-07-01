extends State

@export_category("Connected States")
@export var IdleState: State
@export var RunState: State
@export var CrouchState: State
@export var SlideState: State
@export var DashState: State
@export var JumpState: State
@export var DoubleJumpState: State
@export var WallSlideState: State

var timeout: bool

func coyote_timeout():
	timeout = true

func enter() -> void:
	MovementControl.Momentum = parent.velocity
	parent.PreviousState = parent.CurrentState
	parent.CurrentState = "Fall"
	timeout = false
	var CoyoteTimer = Timer.new()
	CoyoteTimer.one_shot = true
	CoyoteTimer.wait_time = 0.1
	CoyoteTimer.timeout.connect(coyote_timeout)
	add_child(CoyoteTimer)
	CoyoteTimer.start()

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("crouch"):
		if parent.InputDir.x == 0 or  parent.InputDir.z == 0:
			return CrouchState
		return SlideState
	
	if !parent.InputDir == Vector3.ZERO and event.is_action_pressed("dash"):
			return DashState
	
	if event.is_action_pressed("jump") and  !parent.is_on_floor():
		if timeout:
			if !parent.Jumped:
				return DoubleJumpState
			return null
		else:
			if parent.PreviousState == "Run":
				return JumpState
			elif !parent.Jumped:
				return DoubleJumpState
			return null
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += MovementControl._get_gravity() * delta
	MovementControl.fall()
	
	if parent.is_on_wall() and !parent.is_on_floor() and !parent.InputDir == Vector3.ZERO and !parent.WallSlided:
		return WallSlideState
	
	if parent.is_on_floor():
		if pivot.IsInSideView:
			if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
				return RunState
			return IdleState
		elif !pivot.IsInSideView:
			if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down"):
				return RunState
			return IdleState
	return null
