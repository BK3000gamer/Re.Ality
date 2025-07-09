extends State

@export var TopZ: State
@export var TopXZ: State
@export var TopZX: State
@export var SideX: State
@export var MiddleX: State

var timeout: bool

func hold_timeout():
	timeout = true

func enter() -> void:
	pivot.CurrentState = "TopX"
	pivot.CurrentView = "Top"

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("rotate_right") or Input.is_action_just_pressed("rotate_left") or Input.is_action_just_pressed("rotate_up") or Input.is_action_just_pressed("rotate_down"):
		timeout = false
		var HoldTimer = Timer.new()
		HoldTimer.one_shot = true
		HoldTimer.wait_time = 0.2
		HoldTimer.timeout.connect(hold_timeout)
		add_child(HoldTimer)
		HoldTimer.start()
	
	if event.is_action_released("rotate_right"):
		if timeout:
			RotationControl.rotationDegree = 90
			RotationControl._camera_right()
			return TopZ
		elif !timeout:
			RotationControl.rotationDegree = 45
			RotationControl._camera_right()
			return TopXZ
	elif event.is_action_released("rotate_left"):
		if timeout:
			RotationControl.rotationDegree = 90
			RotationControl._camera_left()
			return TopZ
		elif !timeout:
			RotationControl.rotationDegree = 45
			RotationControl._camera_left()
			return TopZX
	elif event.is_action_released("rotate_down"):
		if timeout:
			RotationControl.rotationDegree = 90
			RotationControl._camera_down()
			return SideX
		elif !timeout:
			RotationControl.rotationDegree = 45
			RotationControl._camera_down()
			return MiddleX
	return null
