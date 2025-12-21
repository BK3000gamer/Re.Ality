extends Node3D
class_name Pivot

var CurrentView: String
var CameraRotationTarget: Vector3

var CamPos
var CurrentState: String
var PivotRot

@onready var StateMachine = $"Rotation State Machine"
@onready var MovementControl = $"Movement Control"
@onready var RotationControl = $"Rotation Control"
@onready var Camera = $Camera3D

func _ready() -> void:
	StateMachine.init(self)
	StateMachine.init_sibling("Player")
	MovementControl.init(self)
	MovementControl.init_sibling("Player")
	RotationControl.init(self)

func _process(_delta: float) -> void:
	PivotRot = rad_to_deg(rotation.y)
	PivotRot = round(PivotRot)
	
	CamPos = Camera.global_position

func _unhandled_input(event: InputEvent) -> void:
	StateMachine.process_input(event)

func _physics_process(delta: float) -> void:
	StateMachine.process_physics(delta)
