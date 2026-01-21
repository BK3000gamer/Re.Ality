extends Node

@onready var animationTree := $"../BodyAnimationTree"
@onready var animationPlayer := $"../BodyAnimationPlayer"
@onready var player := $".."
@onready var gunArm := $"../Sprites/Body/Gun Arm"
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
		
		if  -(PI*0.5) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.4375):
			gunArm.frame = 36
		elif  -(PI*0.4375) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.3125):
			gunArm.frame = 37
		elif  -(PI*0.3125) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.1875):
			gunArm.frame = 38
		elif  -(PI*0.1875) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.0625):
			gunArm.frame = 39
		elif  -(PI*0.0625) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.0625:
			gunArm.frame = 40
		elif  PI*0.0625 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.1875:
			gunArm.frame = 41
		elif  PI*0.1875 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.3125:
			gunArm.frame = 42
		elif  PI*0.3125 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.4375:
			gunArm.frame = 43
		elif  PI*0.4375 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.5:
			gunArm.frame = 44
		elif  PI*0.5 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.5625:
			gunArm.frame = 53
		elif  PI*0.5625 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.6875:
			gunArm.frame = 52
		elif  PI*0.6875 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.8125:
			gunArm.frame = 51
		elif  PI*0.8125 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.9375:
			gunArm.frame = 50
		elif  PI*0.9375 < playerPos.angle_to_point(mousePos) or playerPos.angle_to_point(mousePos) < -(PI*0.9375):
			gunArm.frame = 49
		elif  -(PI*0.9375) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.8125):
			gunArm.frame = 48
		elif  -(PI*0.8125) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.6875):
			gunArm.frame = 47
		elif  -(PI*0.6875) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.5625):
			gunArm.frame = 46
		elif  -(PI*0.5625) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.5):
			gunArm.frame = 45
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
		
		if pivot.CurrentView == "Middle":
			if  -(PI*0.5625) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.4375):
				gunArm.frame = 22
			elif  -(PI*0.4375) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.3125):
				gunArm.frame = 21
			elif  -(PI*0.3125) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.1875):
				gunArm.frame = 20
			elif  -(PI*0.1875) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.0625):
				gunArm.frame = 19
			elif  -(PI*0.0625) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.0625:
				gunArm.frame = 18
			elif  PI*0.0625 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.1875:
				gunArm.frame = 33
			elif  PI*0.1875 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.3125:
				gunArm.frame = 32
			elif  PI*0.3125 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.4375:
				gunArm.frame = 31
			elif  PI*0.4375 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.5625:
				gunArm.frame = 30
			elif  PI*0.5625 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.6875:
				gunArm.frame = 29
			elif  PI*0.6875 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.8125:
				gunArm.frame = 28
			elif  PI*0.8125 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.9375:
				gunArm.frame = 27
			elif  PI*0.9375 < playerPos.angle_to_point(mousePos) or playerPos.angle_to_point(mousePos) < -(PI*0.9375):
				gunArm.frame = 26
			elif  -(PI*0.9375) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.8125):
				gunArm.frame = 25
			elif  -(PI*0.8125) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.6875):
				gunArm.frame = 24
			elif  -(PI*0.6875) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.5625):
				gunArm.frame = 23
		elif pivot.CurrentView == "Top":
			if  -(PI*0.5625) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.4375):
				gunArm.frame = 10
			elif  -(PI*0.4375) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.3125):
				gunArm.frame = 11
			elif  -(PI*0.3125) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.1875):
				gunArm.frame = 12
			elif  -(PI*0.1875) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.0625):
				gunArm.frame = 13
			elif  -(PI*0.0625) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.0625:
				gunArm.frame = 14
			elif  PI*0.0625 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.1875:
				gunArm.frame = 15
			elif  PI*0.1875 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.3125:
				gunArm.frame = 0
			elif  PI*0.3125 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.4375:
				gunArm.frame = 1
			elif  PI*0.4375 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.5625:
				gunArm.frame = 2
			elif  PI*0.5625 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.6875:
				gunArm.frame = 3
			elif  PI*0.6875 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.8125:
				gunArm.frame = 4
			elif  PI*0.8125 < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < PI*0.9375:
				gunArm.frame = 5
			elif  PI*0.9375 < playerPos.angle_to_point(mousePos) or playerPos.angle_to_point(mousePos) < -(PI*0.9375):
				gunArm.frame = 6
			elif  -(PI*0.9375) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.8125):
				gunArm.frame = 7
			elif  -(PI*0.8125) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.6875):
				gunArm.frame = 8
			elif  -(PI*0.6875) < playerPos.angle_to_point(mousePos) and playerPos.angle_to_point(mousePos) < -(PI*0.5625):
				gunArm.frame = 9
