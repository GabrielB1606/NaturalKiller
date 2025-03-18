extends CharacterState

@onready var cell: Cell = $"../../Visuals/Cell"
@onready var hold_area: Area3D = $"../../Visuals/HoldArea"

# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	cell.set_arms("reaching")

func onInput(event: InputEvent, movement_vector: Vector3, look_vector: Vector3):
	if event.is_action_released("reach"):
		get_root().dispatch("to_passive")
	#elif event.is_action_pressed("hold") && hold_area.has_overlapping_bodies():
		#CrawlerManager.player.set_body_held(hold_area.get_overlapping_bodies()[0])
		#get_root().dispatch("to_hold")


func _on_hold_area_body_entered(body: Node3D) -> void:
	if !get_root().NPC && body is NPCharacter:
		CrawlerManager.player.set_body_held(body)
		get_root().dispatch("to_hold")
	elif get_root().NPC && body is PlayerCharacter:
		get_root().dispatch("to_hold")
