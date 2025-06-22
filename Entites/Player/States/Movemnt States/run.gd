extends State

@export var IdleState: State
@export var JumpState: State
@export var FallState: State
@export var SlideState: State
@export var DashState: State

func enter() -> void:
	MovementControl.Speed = 2
	parent.Jumped = false
	parent.WallSlided = false
	parent.CurrentState = "Run"

func process_input(event: InputEvent) -> State:
	if pivot.IsInSideView:
		if event.is_action_pressed("jump") and parent.is_on_floor():
			return JumpState
	
	if event.is_action_pressed("crouch"):
		return SlideState
	
	if event.is_action_pressed("dash"):
		return DashState
	return null

func process_physics(delta: float) -> State:
	MovementControl.run()
	
	if parent.InputDir.x == 0 and parent.InputDir.z == 0:
		return IdleState
	
	if !parent.is_on_floor():
		return FallState
	else:
		parent.Jumped = false
		parent.SuperJumped = false
	return null
