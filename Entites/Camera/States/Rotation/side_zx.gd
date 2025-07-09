extends State

@export var SideXZ: State
@export var SideX: State
@export var SideZ: State
@export var TopZX: State
@export var MiddleZX: State

var timeout: bool

func hold_timeout():
	timeout = true

func enter() -> void:
	pivot.CurrentState = "SideZX"
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
			return SideXZ
		elif !timeout:
			RotationControl.rotationDegree = 45
			RotationControl._camera_right()
			return SideX
	elif event.is_action_released("rotate_left"):
		if timeout:
			RotationControl.rotationDegree = 90
			RotationControl._camera_left()
			return SideXZ
		elif !timeout:
			RotationControl.rotationDegree = 45
			RotationControl._camera_left()
			return SideZ
	elif event.is_action_released("rotate_up"):
		if timeout:
			RotationControl.rotationDegree = 90
			RotationControl._camera_up()
			return TopZX
		elif !timeout:
			RotationControl.rotationDegree = 45
			RotationControl._camera_up()
			return MiddleZX
	return null
