extends CharacterStateMachine

@onready var state_passive: LimboState = $Passive
@onready var state_reach: LimboState = $Reach
@onready var state_hold: LimboState = $Hold
@onready var state_captured: LimboState = $Captured

@onready var visuals: Node3D = $"../Visuals"

func init(agent: Node3D) -> void:
	# Define Transitions
	add_transition(ANYSTATE, state_reach, "to_reach")
	add_transition(state_reach, state_hold, "to_hold")
	add_transition(ANYSTATE, state_passive, "to_passive")
	add_transition(ANYSTATE, state_captured, "to_captured")
	# Initialize
	initial_state = state_passive
	super.init(agent)
	
func onPhysicsProcess(delta: float) -> void:
	get_active_state().onPhysicsProcess(delta)

func onInput(event: InputEvent, movement_vector: Vector3, look_vector: Vector3) -> void:
	var player: PlayerCharacter = agent
	if !look_vector.is_zero_approx():
		visuals.look_at( visuals.global_position + look_vector )

	get_active_state().onInput(event, movement_vector, look_vector)
