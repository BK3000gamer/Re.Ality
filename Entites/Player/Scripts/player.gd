extends CharacterBody3D
class_name Player

var InputDir := Vector3.ZERO
var Jumped: bool =  false
var SuperJumped: bool = false
var WallSlided: bool = false
var CurrentState: String
var PreviousState: String

var pivot

@onready var StateMachine = $"Movement State Machine"
@onready var MovementControl = $"Movement Control"
@onready var AnimationControl = $"Animation Control"

func _ready() -> void:
	StateMachine.init(self)
	StateMachine.init_sibling("Pivot")
	MovementControl.init(self)
	MovementControl.init_sibling("Pivot")
	AnimationControl.init_sibling("Pivot")
	
	pivot = get_parent().get_node("Pivot")

func _unhandled_input(event: InputEvent) -> void:
	StateMachine.process_input(event)

func _physics_process(delta: float) -> void:
	StateMachine.process_physics(delta)
	MovementControl.process_physics(delta)
