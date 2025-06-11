extends State

@export var SideWE: State
@export var TopNS: State

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("rotate_right"):
		_camera_right()
		pivot.IsInSideView = true
		return SideWE
	elif event.is_action_pressed("rotate_left"):
		_camera_left()
		pivot.IsInSideView = true
		return SideWE	
	elif event.is_action_pressed("rotate_up_down"):
		_camera_up()
		pivot.IsInSideView = false
		return TopNS
	return null

func _camera_right():
	var newRotation: Vector3 = pivot.CameraRotationTarget + Vector3(0,90.0,0)
	var tween := get_tree().create_tween()
	tween.tween_property(pivot, "rotation_degrees", newRotation, 0.2).from(pivot.CameraRotationTarget)
	pivot.CameraRotationTarget = newRotation
	pivot.rotate_y(pivot.CameraRotationTarget.y)

func _camera_left():
	var newRotation: Vector3 = pivot.CameraRotationTarget + Vector3(0,-90.0,0)
	var tween := get_tree().create_tween()
	tween.tween_property(pivot, "rotation_degrees", newRotation, 0.2).from(pivot.CameraRotationTarget)
	pivot.CameraRotationTarget = newRotation
	pivot.rotate_y(pivot.CameraRotationTarget.y)
	
func _camera_up():
	var newRotation: Vector3 = pivot.CameraRotationTarget + Vector3(-90.0,0,0)
	var tween := get_tree().create_tween()
	tween.tween_property(pivot, "rotation_degrees", newRotation, 0.2).from(pivot.CameraRotationTarget)
	pivot.CameraRotationTarget = newRotation
	pivot.rotate_y(pivot.CameraRotationTarget.y)
