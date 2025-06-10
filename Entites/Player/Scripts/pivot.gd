extends Node3D
class_name Pivot

var IsInSideView: bool =  true
var CameraRotationTarget: Vector3

@onready var StateMachine = $"../Camera State Machine"

func _ready() -> void:
	StateMachine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	StateMachine.process_input(event)

func _physics_process(delta: float) -> void:
	StateMachine.process_physics(delta)
