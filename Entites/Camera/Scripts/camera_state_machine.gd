extends Node

@export var StartingState: State
@export var CurrentState: State

func init(Parent: Pivot) -> void:
	for child in get_children():
		child.pivot = Parent

func init_sibling(PlayerName: String) -> void:
	var grandparent = get_parent().get_parent().get_parent()
	
	var subview = grandparent.get_node("Entity")
	
	var SiblingPlayer = subview.get_node_or_null(PlayerName)
	if SiblingPlayer == null:
		push_warning("Player node not found.")
		return
	
	for child in get_children():
		child.player = SiblingPlayer
	
	change_state(StartingState)

func change_state(NewState: State) -> void:
	if CurrentState:
		CurrentState.exit()
	
	CurrentState = NewState
	CurrentState.enter()

func process_physics(delta: float) -> void:
	var NewState = CurrentState.process_physics(delta)
	if NewState:
		change_state(NewState)
		
func process_input(event: InputEvent) -> void:
	var NewState = CurrentState.process_input(event)
	if NewState:
		change_state(NewState)
