extends CharacterState

@onready var character: Cell = $"../../Visuals/Cell"
@export var animation: StringName = "run"
@onready var root: CharacterBody3D = $"../.."

func _enter() -> void:
	#character.play_animation(animation, Cell.AnimationSegment.LOWER)
	character.set_legs(1)

func onInput(event: InputEvent, movement_vector: Vector3, look_vector: Vector3):
	if !movement_vector.is_zero_approx() && !look_vector.is_zero_approx():
		if movement_vector.dot(look_vector) >= 0:
			character.set_legs(1)
		else:
			character.set_legs(-1)
	#if movement_vector.is_zero_approx():
		#get_root().dispatch("to_idle")
	pass

func onPhysicsProcess(delta: float) -> void:
	if agent.velocity.is_zero_approx():
		get_root().dispatch("to_idle")
