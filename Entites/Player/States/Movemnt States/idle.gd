extends State

@export var RunState: State
@export var JumpState: State
@export var FallState: State
@export var CrouchState: State

func enter() -> void:
	parent.velocity.x = 0
	parent.velocity.z = 0
	parent.Jumped = false
	parent.WallSlided = false

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("crouch"):
		return CrouchState
	return null

func process_physics(delta: float) -> State:
	if pivot.IsInSideView:
		if !parent.InputDir == Vector3.ZERO:
			return RunState
		elif Input.is_action_pressed("jump") and parent.is_on_floor():
			return JumpState
	elif !pivot.IsInSideView:
		if !parent.InputDir == Vector3.ZERO:
			return RunState
	
	if !parent.is_on_floor():
		return FallState
	else:
		parent.Jumped = false
		parent.SuperJumped = false
	return null
