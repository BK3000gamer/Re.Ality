extends State

@export var IdleState: State
@export var RunState: State
@export var CrouchState: State
@export var SlideState: State
@export var DashState: State
@export var DoubleJumpState: State
@export var WallSlideState: State

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("crouch"):
		if parent.InputDir == Vector3.ZERO:
			return CrouchState
		return SlideState
	
	if !parent.InputDir == Vector3.ZERO and event.is_action_pressed("dash"):
			return DashState
	
	if event.is_action_pressed("jump") and !parent.is_on_floor() and !parent.Jumped:
		return DoubleJumpState
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += MovementControl._get_gravity() * delta
	MovementControl.run()
	
	if parent.is_on_wall() and !parent.InputDir == Vector3.ZERO and !parent.WallSlided:
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
