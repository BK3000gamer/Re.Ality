extends CharacterBody3D
class_name Player

var InputDir := Vector3.ZERO
var Jumped: bool =  false
var SuperJumped: bool = false
var CurrentState: String
var PreviousState: String

var pivot

var RoomPos := Vector3.ZERO

var rooms: Array[Node]
@export var CenterThreshold: float = 2.0

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

func _process(_delta: float) -> void:
	var OverlappingRooms = $Area3D.get_overlapping_areas()
	for room in OverlappingRooms:
		if room.is_in_group("rooms"):
			var RoomCentre = room.global_position
			var PlayerPos = global_transform.origin
			var Distance = abs(PlayerPos.y - RoomCentre.y)
			if Distance <= CenterThreshold:
				RoomPos = RoomCentre

func _unhandled_input(event: InputEvent) -> void:
	StateMachine.process_input(event)

func _physics_process(delta: float) -> void:
	StateMachine.process_physics(delta)
	MovementControl.process_physics(delta)
