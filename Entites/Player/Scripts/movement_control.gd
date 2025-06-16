extends Node

var parent: CharacterBody3D
var pivot: Pivot

@export var JumpHeight: float
@export var JumpTimeToPeak: float
@export var JumpTimeToDescent: float
@export var WallJumpPushback: float
@export var MoveSpeed: float
@export var CrouchMultiplier: float
@export var SlideMultiplier: float
@export var SlideDecay: float
@export var DashMultiplier: float
@export var SuperJumpMultiplier: float

var JumpVelocity: float
var JumpGravity: float
var FallGravity: float

func init(Parent: CharacterBody3D) -> void:
	parent = Parent
	
	JumpVelocity = (2.0 * JumpHeight) / JumpTimeToPeak
	JumpGravity = (-2.0 * JumpHeight) / pow(JumpTimeToPeak, 2)
	FallGravity = (-2.0 * JumpHeight) / pow(JumpTimeToDescent, 2)

func init_sibling(PivotName: String) -> void:
	var grandparent = get_parent().get_parent().get_parent()
	
	var subview = grandparent.get_node("Environment")
	
	var SiblingPivot = subview.get_node_or_null(PivotName)
	if SiblingPivot == null:
		push_warning("Pivot node not found.")
		return
	
	pivot = SiblingPivot

func _get_gravity() -> float:
	return JumpGravity if parent.velocity.y > 0.0 else FallGravity

func process_physics(delta: float) -> void:
	parent.velocity.y += _get_gravity() * delta
	parent.InputDir = Vector3.ZERO
	
	if pivot.IsInSideView:
		parent.InputDir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		parent.InputDir = parent.InputDir.rotated(Vector3.UP, pivot.rotation.y).normalized()
	elif !pivot.IsInSideView:
		parent.InputDir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		parent.InputDir.z = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		parent.InputDir = parent.InputDir.rotated(Vector3.UP, pivot.rotation.y).normalized()
	
	parent.move_and_slide()

func run() -> void:
	parent.velocity.x = parent.InputDir.x * MoveSpeed
	parent.velocity.z = parent.InputDir.z * MoveSpeed

func jump() -> void:
	if parent.is_on_floor():
		parent.velocity.y = JumpVelocity
	elif parent. is_on_wall():
		parent.velocity.y = JumpVelocity
		parent.velocity.x = parent.InputDir.x * -WallJumpPushback
		parent.velocity.z = parent.InputDir.z * -WallJumpPushback
	else:
		parent.velocity.y = JumpVelocity

func crouch() -> void:
	parent.velocity.x = parent.InputDir.x * MoveSpeed * CrouchMultiplier
	parent.velocity.z = parent.InputDir.z * MoveSpeed * CrouchMultiplier

func slide() -> void:
	parent.velocity.x = parent.InputDir.x * MoveSpeed * SlideMultiplier
	parent.velocity.z = parent.InputDir.z * MoveSpeed * SlideMultiplier

func slide_decay(delta: float) -> void:
	var HorizontalVelocity = Vector3(parent.velocity.x, 0, parent.velocity.z)
	var Speed = HorizontalVelocity.length()
	if Speed > 0:
		var DecayAmount = SlideDecay * delta
		Speed = max(Speed - DecayAmount, 0)
		HorizontalVelocity = HorizontalVelocity.normalized() * Speed
		
		parent.velocity.x = HorizontalVelocity.x
		parent.velocity.z = HorizontalVelocity.z

func dash() -> void:
	parent.velocity.x = parent.InputDir.x * MoveSpeed * DashMultiplier
	parent.velocity.z = parent.InputDir.z * MoveSpeed * DashMultiplier

func superjump() -> void:
	if pivot.IsInSideView:
		if parent.InputDir == Vector3.ZERO:
			parent.velocity.y = SuperJumpMultiplier * 1.4
		else:
			parent.velocity.x = parent.InputDir.x * SuperJumpMultiplier
			parent.velocity.z = parent.InputDir.z * SuperJumpMultiplier
			parent.velocity.y = 10
	else:
		if !parent.InputDir == Vector3.ZERO:
			parent.velocity.x = parent.InputDir.x * SuperJumpMultiplier
			parent.velocity.z = parent.InputDir.z * SuperJumpMultiplier
			parent.velocity.y = 10

func wall_slide() -> void:
	pass
