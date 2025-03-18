class_name CharacterStateMachine extends LimboHSM

@export var NPC := true

func init(agent: Node3D) -> void:
	initialize(agent)
	set_active(true)

func onInput(event: InputEvent, movement_vector: Vector3, look_vector: Vector3):
	get_active_state().onInput(event, movement_vector, look_vector)
	
func onPhysicsProcess(delta: float) -> void:
	get_active_state().onPhysicsProcess(delta)

func onProcess(delta: float) -> void:
	get_active_state().onProcess(delta)
