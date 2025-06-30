extends State

@export var FallState: State
@export var RunState: State
@export var IdleState: State
@export var CrouchState: State
@export var SlideState: State
@export var DashState: State
@export var DoubleJumpState: State

func enter() -> void:
	parent.PreviousState = parent.CurrentState
	parent.WallSlided = false
	MovementControl.jump()
	parent.CurrentState = "Jump"

func process_input(event: InputEvent) -> State:
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
	
	if parent.velocity.y < 0:
		return FallState
	
	if parent.is_on_floor():
		if parent.InputDir.x == 0 or  parent.InputDir.z == 0:
			return IdleState
		return RunState
	return null
