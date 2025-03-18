extends CharacterState

@onready var cell: Cell = $"../../Visuals/Cell"
@onready var player: PlayerCharacter = $"Player"
@onready var character: CharacterBody3D = $"../.."

# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	#cell.get_node("HoldIndicator").visible = true
	if !get_root().NPC && CrawlerManager.player.body_held:
		CrawlerManager.player.body_held.held = true
		CrawlerManager.player.body_held.set_collision_layer_value(1, false)

func _exit() -> void:
	#cell.get_node("HoldIndicator").visible = false
	if !get_root().NPC && CrawlerManager.player.body_held:
		CrawlerManager.player.body_held.held = false
		CrawlerManager.player.body_held.set_collision_layer_value(1, true)
		CrawlerManager.player.body_held = null

func onInput(event: InputEvent, movement_vector: Vector3, look_vector: Vector3):
	if event.is_action_released("reach"):
		get_root().dispatch("to_passive")
