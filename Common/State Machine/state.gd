extends Node
class_name State

@export var Resources: PlayerStats

@onready var JumpVelocity: float = ((2.0 * Resources.JumpHeight) / Resources.JumpTimeToPeak)
@onready var JumpGravity: float = ((-2.0 * Resources.JumpHeight) / (Resources.JumpTimeToPeak * Resources.JumpTimeToPeak))
@onready var FallGravity: float = ((-2.0 * Resources.JumpHeight) / (Resources.JumpTimeToDescent * Resources.JumpTimeToDescent))

@onready var MoveSpeed = Resources.MoveSpeed

var parent: Player

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

func process_frane(delta: float) -> State:
	return null
