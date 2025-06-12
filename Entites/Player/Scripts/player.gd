extends CharacterBody3D
class_name Player

var InputDir := Vector3.ZERO
var Jumped: bool =  false

@export var Resources: Stats

@onready var StateMachine = $"Movement State Machine"

func _ready() -> void:
	StateMachine.init(self, Resources)
	StateMachine.init_sibling("Pivot")

func _unhandled_input(event: InputEvent) -> void:
	StateMachine.process_input(event)

func _physics_process(delta: float) -> void:
	StateMachine.process_physics(delta)
