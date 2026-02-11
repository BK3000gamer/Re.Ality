extends Node

@onready var animationTree := $"../BodyAnimationTree"
@onready var animationPlayer := $"../BodyAnimationPlayer"
@onready var player := $".."
@onready var Sprite :=$"../Sprite3D"

var mousePos
var pivot
var playerPos

func _ready() -> void:
	Sprite.pixel_size = 0.03125

func init_sibling(PivotName: String) -> void:
	var parent = get_parent().get_parent()
	
	var SiblingPivot = parent.get_node_or_null(PivotName)
	if SiblingPivot == null:
		push_warning("Pivot node not found.")
		return
	
	pivot = SiblingPivot

func _process(_delta: float) -> void:	
	playerPos = Vector2(GetPlayer2dPosition.HorizontalPos, GetPlayer2dPosition.VerticalPos)
	mousePos = get_viewport().get_mouse_position()
	
	var dir = Vector2.ZERO
	if pivot.CurrentView == "Side":
		if  -(PI*0.5) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.5:
			dir.x = 1.0
		elif PI*0.5 < playerPos.angle_to_point(mousePos) or playerPos.angle_to_point(mousePos) < -(PI*0.5):
			dir.x = -1.0
		animationTree.set("parameters/Idle_State_Machine/Idle_Side/blend_position", dir.x)
		
	else:
		if  -(PI*0.875) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.125):
			dir.y = 1.0
		elif  PI*0.125 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.875:
			dir.y = -1.0
		else:
			dir.y = 0.0
		if  -(PI*0.375) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.375:
			dir.x = 1.0
		elif  PI*0.625 < playerPos.angle_to_point(mousePos) or playerPos.angle_to_point(mousePos) < -(PI*0.625):
			dir.x = -1.0
		else:
			dir.x = 0.0
		animationTree.set("parameters/Idle_State_Machine/Idle_Middle/blend_position", dir)
		animationTree.set("parameters/Idle_State_Machine/Idle_Top/blend_position", dir)
