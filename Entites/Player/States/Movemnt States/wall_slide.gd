extends State

@export var JumpState: State
@export var FallState: State
@export var IdleState: State
@export var DashState: State

func process_physics(delta: float) -> State:
	MovementControl.wall_slide()
	
	return null
