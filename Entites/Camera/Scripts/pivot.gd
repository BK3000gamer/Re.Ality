extends Node3D
class_name Pivot

var IsInSideView: bool =  true
var CameraRotationTarget: Vector3

var RoomType:Array[int] = []
var RoomPos
var CamPos
var CurrentState: String

var rooms: Array[Node]
@export var CenterThreshold: float = 2.0

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

func _process(delta: float) -> void:
	print(rad_to_deg(global_rotation.y))
	var OverlappingRooms = $Area3D.get_overlapping_areas()
	for room in OverlappingRooms:
		if room.is_in_group("rooms"):
			var RoomCentre = room.global_position
			var PivotPos = global_transform.origin
			var Distance = PivotPos.distance_to(RoomCentre)
			if Distance <= CenterThreshold:
				RoomType = room.RoomType
				RoomPos = RoomCentre
	
	CamPos = Camera.global_position

func _unhandled_input(event: InputEvent) -> void:
	StateMachine.process_input(event)

func _physics_process(delta: float) -> void:
	StateMachine.process_physics(delta)
