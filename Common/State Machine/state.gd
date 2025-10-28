extends Node
class_name State

@export var RotationControl: Node
@export var MovementControl: Node

var JumpVelocity: float
var JumpGravity: float
var FallGravity: float
var MoveSpeed

var parent: Player
var pivot: Pivot
var player: Player

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
