extends State

@export_category("Connected States")
@export var FallState: State
@export var RunState: State
@export var IdleState: State
@export var CrouchState: State
@export var SlideState: State
@export var DashState: State
@export var WallSlideState: State

func enter() -> void:
	parent.PreviousState = parent.CurrentState
	parent.Jumped = true
	MovementControl.jump()
	parent.CurrentState = "Double Jump"

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("crouch"):
		if parent.InputDir.x == 0 or  parent.InputDir.z == 0:
			return CrouchState
		return SlideState
	
	if !parent.InputDir == Vector3.ZERO:
		if event.is_action_pressed("dash"):
			return DashState
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += MovementControl._get_gravity() * delta
	if parent.velocity.y < 0:
		return FallState
	
	if parent.is_on_wall() and !parent.is_on_floor() and !parent.InputDir == Vector3.ZERO:
		return WallSlideState
	
	if parent.is_on_floor():
		if parent.InputDir.x == 0 or  parent.InputDir.z == 0:
			return IdleState
		return RunState
	return null
