extends State

@export var MiddleZX: State
@export var MiddleZ: State
@export var MiddleX: State
@export var TopXZ: State
@export var SideXZ: State

var timeout: bool

func hold_timeout():
	timeout = true

func enter() -> void:
	pivot.CurrentState = "MiddleXZ"
	pivot.CurrentView = "Middle"

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
			return MiddleZX
		elif !timeout:
			RotationControl.rotationDegree = 45
			RotationControl._camera_right()
			return MiddleZ
	elif event.is_action_released("rotate_left"):
		if timeout:
			RotationControl.rotationDegree = 90
			RotationControl._camera_left()
			return MiddleZX
		elif !timeout:
			RotationControl.rotationDegree = 45
			RotationControl._camera_left()
			return MiddleX
	elif event.is_action_released("rotate_up"):
		RotationControl.rotationDegree = 45
		RotationControl._camera_up()
		return TopXZ
	elif event.is_action_released("rotate_down"):
		RotationControl.rotationDegree = 45
		RotationControl._camera_down()
		return SideXZ
	return null
