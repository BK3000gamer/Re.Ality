extends State

@export var IdleState: State
@export var RunState: State
@export var FallState: State
@export var CrouchState: State

var decay = 5

func process_physics(delta: float) -> State:
	parent.velocity.y += _get_gravity() * delta
	
	parent.InputDir = Vector3.ZERO
	
	if pivot.IsInSideView:
		parent.InputDir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		parent.InputDir = parent.InputDir.rotated(Vector3.UP, pivot.rotation.y).normalized()
	elif !pivot.IsInSideView:
		parent.InputDir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		parent.InputDir.z = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		parent.InputDir = parent.InputDir.rotated(Vector3.UP, pivot.rotation.y).normalized()
	
	if parent.velocity.x > 0:
		parent.velocity.x -= decay * delta
		if parent.velocity.x < 0:
			parent.velocity.x = 0
			return CrouchState
	if parent.velocity.x < 0:
		parent.velocity.x += decay * delta
		if parent.velocity.x > 0:
			parent.velocity.x = 0
			return CrouchState
	
	if parent.velocity.z > 0:
		parent.velocity.z -= decay * delta
		if parent.velocity.z < 0:
			parent.velocity.z = 0
			return CrouchState
	if parent.velocity.z < 0:
		parent.velocity.z += decay * delta
		if parent.velocity.z > 0:
			parent.velocity.z = 0
			return CrouchState
	
	if !Input.is_action_pressed("crouch"):
		if parent.is_on_floor():
			if parent.InputDir == Vector3.ZERO:
				return IdleState
			return RunState
		else:
			return FallState
	parent.move_and_slide()
	return null
