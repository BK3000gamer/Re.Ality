extends Node

var pivot: Pivot

func init(Parent: Pivot) -> void:
	pivot = Parent

func _camera_right(rotationDegree: float):
	var newRotation: Vector3 = pivot.CameraRotationTarget + Vector3(0,rotationDegree,0)
	var tween := get_tree().create_tween()
	tween.tween_property(pivot, "rotation_degrees", newRotation, 0.15).from(pivot.CameraRotationTarget)
	pivot.CameraRotationTarget = newRotation

func _camera_left(rotationDegree: float):
	var newRotation: Vector3 = pivot.CameraRotationTarget + Vector3(0,-rotationDegree,0)
	var tween := get_tree().create_tween()
	tween.tween_property(pivot, "rotation_degrees", newRotation, 0.15).from(pivot.CameraRotationTarget)
	pivot.CameraRotationTarget = newRotation
	
func _camera_up(rotationDegree: float):
	var newRotation: Vector3 = pivot.CameraRotationTarget + Vector3(-rotationDegree,0,0)
	var tween := get_tree().create_tween()
	tween.tween_property(pivot, "rotation_degrees", newRotation, 0.15).from(pivot.CameraRotationTarget)
	pivot.CameraRotationTarget = newRotation
	
func _camera_down(rotationDegree: float):
	var newRotation: Vector3 = pivot.CameraRotationTarget + Vector3(rotationDegree,0,0)
	var tween := get_tree().create_tween()
	tween.tween_property(pivot, "rotation_degrees", newRotation, 0.15).from(pivot.CameraRotationTarget)
	pivot.CameraRotationTarget = newRotation
