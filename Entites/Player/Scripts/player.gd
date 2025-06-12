extends CharacterBody3D
class_name Player

var InputDir := Vector3.ZERO
var Jumped: bool =  false

@export var Resources: Stats

@onready var MoveStateMachine = $"Movement State Machine"
@onready var CamStateMachine = $"Camera State Machine"

func _ready() -> void:
	MoveStateMachine.init(self, Resources)
	MoveStateMachine.init_sibling("Pivot")
	CamStateMachine.init("Pivot")

func _unhandled_input(event: InputEvent) -> void:
	MoveStateMachine.process_input(event)
	CamStateMachine.process_input(event)

func _physics_process(delta: float) -> void:
	MoveStateMachine.process_physics(delta)
	CamStateMachine.process_physics(delta)
