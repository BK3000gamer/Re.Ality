extends State

@export var FallState: State
@export var RunState: State
@export var IdleState: State
@export var CrouchState: State
@export var SlideState: State
@export var DashState: State
@export var WallSlideState: State

func enter() -> void:
	parent.Jumped = true
	MovementControl.jump()

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("crouch"):
		if parent.InputDir == Vector3.ZERO:
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
	
	if parent.is_on_wall() and !parent.InputDir == Vector3.ZERO and !parent.WallSlided:
		return WallSlideState
	
	if parent.is_on_floor():
		if parent.InputDir == Vector3.ZERO:
			return IdleState
		return RunState
	return null
