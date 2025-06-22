extends State

@export var FallState: State
@export var RunState: State
@export var IdleState: State
@export var CrouchState: State
@export var SlideState: State
@export var DashState: State
@export var DoubleJumpState: State
@export var WallSlideState: State

var timeout: bool

func jump_timeout():
	timeout = true

func enter() -> void:
	parent.CurrentState = "Super Jump"
	parent.SuperJumped = true
	parent.WallSlided = false
	timeout = false
	var JumpTimer = Timer.new()
	JumpTimer.one_shot = true
	JumpTimer.wait_time = 0.4
	JumpTimer.timeout.connect(jump_timeout)
	add_child(JumpTimer)
	JumpTimer.start()
	
	MovementControl.superjump()

func process_input(event: InputEvent) -> State:
	MovementControl.run()
	if event.is_action_pressed("crouch"):
		if parent.InputDir.x == 0 or  parent.InputDir.z == 0:
			return CrouchState
		return SlideState
	
	if !parent.InputDir == Vector3.ZERO and event.is_action_pressed("dash"):
			return DashState
	
	if event.is_action_pressed("jump") and !parent.is_on_floor() and !parent.Jumped:
		return DoubleJumpState
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += MovementControl._get_gravity() * delta
	if timeout:
		if parent.velocity.y < 0:
			return FallState
			
		if parent.is_on_floor():
			if parent.InputDir.x == 0 or  parent.InputDir.z == 0:
				return IdleState
			return RunState
	
	if parent.is_on_wall() and !parent.InputDir == Vector3.ZERO:
		return WallSlideState
	
	parent.move_and_slide()
	return null
