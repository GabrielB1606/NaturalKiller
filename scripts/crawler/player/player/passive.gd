extends CharacterState

@export var animation: StringName = "upper_idle"
@onready var player: CharacterBody3D = $"../.."
@onready var cell: Cell = $"../../Visuals/Cell"

func _enter() -> void:
	pass
	#print(cell.get_arms())
	#if cell.get_arms() == "reaching":
		#get_root().dispatch("to_reach")

func onInput(event: InputEvent, movement_vector: Vector3, look_vector: Vector3):
	if event.is_action_pressed("reach") || Input.is_action_pressed("reach"):
		get_root().dispatch("to_reach")

func onPhysicsProcess(delta: float):
	if player.velocity.is_zero_approx():
		cell.set_arms("idle")
	else:
		cell.set_arms("run")
