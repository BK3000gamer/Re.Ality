extends State

@export_category("Connected States")
@export var IdleState: State
@export var RunState: State
@export var FallState: State
@export var CrouchState: State
@export var DashState: State
@export var SuperJumpState: State

func enter() -> void:
	parent.PreviousState = parent.CurrentState
	MovementControl.slide()
	parent.CurrentState = "Slide"

func process_input(event: InputEvent) -> State:
	if !parent.InputDir == Vector3.ZERO and event.is_action_pressed("dash"):
			return DashState
	
	if event.is_action_pressed("jump") and !parent.SuperJumped:
		return SuperJumpState
	return null

func process_physics(delta: float) -> State:	
	MovementControl.slide_decay(delta)
		
	if parent.velocity.x == 0 and parent.velocity.z == 0:
		if !parent.is_on_floor():
			return FallState
		return CrouchState
	
	if parent.is_on_floor():
		parent.Jumped = false
		parent.SuperJumped = false
		if !Input.is_action_pressed("crouch"):
			if parent.InputDir.x == 0 or  parent.InputDir.z == 0:
				return IdleState
			return RunState
	return null
