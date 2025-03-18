class_name MovementCharacterStateMachine
extends CharacterStateMachine

@onready var state_idle: LimboState = $Idle
@onready var state_move: LimboState = $Move

@export var freeze = false

func init(agent: Node3D) -> void:
	# Define Transitions
	add_transition(state_idle, state_move, "to_move")
	add_transition(state_move,state_idle, "to_idle")
	
	# Initialize
	initial_state = state_idle
	super.init(agent)

func onPhysicsProcess(delta: float) -> void:
	get_active_state().onPhysicsProcess(delta)

func onInput(event: InputEvent, movement_vector: Vector3, look_vector: Vector3) -> void:
	var player: PlayerCharacter = agent
	if freeze || movement_vector.is_zero_approx():
		player.velocity.x = move_toward(movement_vector.x, 0, player.stats.current_speed)
		player.velocity.z = move_toward(movement_vector.z, 0, player.stats.current_speed)
	else:
		player.velocity.x = movement_vector.x * player.stats.current_speed
		player.velocity.z = movement_vector.z * player.stats.current_speed
	get_active_state().onInput(event, movement_vector, look_vector)
