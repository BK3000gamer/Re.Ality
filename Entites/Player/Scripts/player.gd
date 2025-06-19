extends CharacterBody3D
class_name Player

var InputDir := Vector3.ZERO
var Jumped: bool =  false
var SuperJumped: bool = false

@onready var StateMachine = $"Movement State Machine"
@onready var MovementControl = $"Movement Control"

func _ready() -> void:
	StateMachine.init(self)
	StateMachine.init_sibling("Pivot")
	MovementControl.init(self)
	MovementControl.init_sibling("Pivot")

func _unhandled_input(event: InputEvent) -> void:
	StateMachine.process_input(event)

func _physics_process(delta: float) -> void:
	StateMachine.process_physics(delta)
	MovementControl.process_physics(delta)
