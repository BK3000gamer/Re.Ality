extends Node
class_name MovementStateMachine

@export var StartingState: State
@export var CurrentState: State

func init(Parent: Player) -> void:
	for child in get_children():
		child.parent = Parent

func init_sibling(PivotName: String) -> void:
	var grandparent = get_parent().get_parent()
	if grandparent == null:
		return
	
	var SiblingPivot = grandparent.get_node_or_null(PivotName)
	if SiblingPivot == null:
		push_warning("Pivot node not found.")
		return
	
	var parent = get_parent()
	if parent == null:
		return
	
	for sibling in parent.get_children():
		for grandchild in sibling.get_children():
			grandchild.pivot = SiblingPivot
	
	change_state(StartingState)

func change_state(NewState: State) -> void:
	if CurrentState:
		CurrentState.exit()
	
	CurrentState = NewState
	CurrentState.enter()

func process_physics(delta: float) -> void:
	print(CurrentState)
	var NewState = CurrentState.process_physics(delta)
	if NewState:
		change_state(NewState)

func process_input(event: InputEvent) -> void:
	var NewState = CurrentState.process_input(event)
	if NewState:
		change_state(NewState)
