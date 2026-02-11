extends Node

@export var attacktTime: float = 2.0
@export var cooldown: float = 1.0

var attackTimer: float
var cooldownTimer: float

var attackNumber: int = 0
var attacked: bool = false

enum AttackState {
	None,
	Attack
}

var CurrentState: AttackState = AttackState.None

func _process(delta: float) -> void:
	print (attacked)
	match CurrentState:
		AttackState.None:
			if Input.is_action_pressed("attack_left"):
				change_state(AttackState.Attack)
		AttackState.Attack:
			attackTimer -= delta
			cooldownTimer -= delta
			if Input.is_action_just_pressed("attack_left") and attackNumber < 3:
				attacked = true
			if cooldownTimer <= 0.0 and attacked:
				attacked = false
				attackNumber += 1
				cooldownTimer = cooldown
				attackTimer = attacktTime
			if attackTimer <= 0.0 or attackNumber > 3:
				change_state(AttackState.None)

func change_state (NewState: AttackState) -> void:
	CurrentState = NewState
	match CurrentState:
		AttackState.None:
			attackTimer = attacktTime
			attackNumber = 0
		AttackState.Attack:
			attackNumber = 1
			cooldownTimer = cooldown
