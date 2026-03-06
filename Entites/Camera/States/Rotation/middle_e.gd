extends State

@export var Right90: State
@export var Right45: State
@export var Left90: State
@export var Left45: State
@export var Up: State
@export var Down: State

var timeout: bool

func hold_timeout():
	timeout = true

func enter() -> void:
	pivot.CurrentState = "MiddleE"
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
			RotationControl._camera_right(90)
			return Right90
		elif !timeout:
			RotationControl._camera_right(45)
			return Right45
	elif event.is_action_released("rotate_left"):
		if timeout:
			RotationControl._camera_left(90)
			return Left90
		elif !timeout:
			RotationControl._camera_left(45)
			return Left45
	elif event.is_action_released("rotate_up"):
		RotationControl._camera_up(45)
		return Up
	elif event.is_action_released("rotate_down"):
		RotationControl._camera_down(45)
		return Down
	return null
