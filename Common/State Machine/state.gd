extends Node
class_name State

@export var Resources: Stats

var JumpVelocity: float
var JumpGravity: float
var FallGravity: float
var MoveSpeed

var parent: Player
var pivot: Pivot

func _ready():
	if Resources == null:
		push_error("Stats resource not assigned!")
		return

	JumpVelocity = (2.0 * Resources.JumpHeight) / Resources.JumpTimeToPeak
	JumpGravity = (-2.0 * Resources.JumpHeight) / pow(Resources.JumpTimeToPeak, 2)
	FallGravity = (-2.0 * Resources.JumpHeight) / pow(Resources.JumpTimeToDescent, 2)
	MoveSpeed = Resources.MoveSpeed

func _get_gravity() -> float:
	return JumpGravity if parent.velocity.y > 0.0 else FallGravity

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
