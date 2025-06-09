extends Node
class_name StateMachine

@export var StartingState: State
@export var CurrentState: State

func init(Parent: Player) -> void:
	for child in get_children():
		child.parent = Parent
	
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
		
func process_frame(delta: float) -> void:
	var NewState = CurrentState.process_frame(delta)
	if NewState:
		change_state(NewState)
