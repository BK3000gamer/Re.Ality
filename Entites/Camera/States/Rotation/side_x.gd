extends State

@export var SideZ: State
@export var SideXZ: State
@export var SideZX: State
@export var TopX: State
@export var MiddleX: State

var timeout: bool

func hold_timeout():
	timeout = true

func enter() -> void:
	pivot.CurrentState = "SideX"
	pivot.CurrentView = "Side"

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
			return SideZ
		elif !timeout:
			RotationControl.rotationDegree = 45
			RotationControl._camera_right()
			return SideXZ
	elif event.is_action_released("rotate_left"):
		if timeout:
			RotationControl.rotationDegree = 90
			RotationControl._camera_left()
			return SideZ
		elif !timeout:
			RotationControl.rotationDegree = 45
			RotationControl._camera_left()
			return SideZX
	elif event.is_action_released("rotate_up"):
		if timeout:
			RotationControl.rotationDegree = 90
			RotationControl._camera_up()
			return TopX
		elif !timeout:
			RotationControl.rotationDegree = 45
			RotationControl._camera_up()
			return MiddleX
	return null
