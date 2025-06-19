extends State

@export var JumpState: State
@export var FallState: State
@export var IdleState: State
@export var DashState: State
@export var SlideState: State

var timeout: bool

func slide_timeout():
	timeout = true

func enter() -> void:
	timeout = false
	var SlideTimer = Timer.new()
	SlideTimer.one_shot = true
	SlideTimer.wait_time = 0.7
	SlideTimer.timeout.connect(slide_timeout)
	add_child(SlideTimer)
	SlideTimer.start()

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("dash"):
		return DashState
	
	if event.is_action_pressed("jump"):
		return JumpState
	
	if event.is_action_pressed("crouch"):
		return SlideState
	return null

func process_physics(delta: float) -> State:
	MovementControl.wall_slide(delta)
	
	if (parent.InputDir.x == 0 and parent.InputDir.z == 0) or !parent.is_on_wall():
		return FallState
	
	if timeout:
		return FallState
	
	if parent.is_on_floor():
		return IdleState
	
	return null
