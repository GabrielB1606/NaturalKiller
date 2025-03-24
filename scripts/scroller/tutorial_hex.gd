extends Control

@onready var tutorial: Control = $"."
@onready var tube: Tube = $"../../test_tube2_culling_fix"
@onready var exit: Button = $"move&attack/Exit"

func _ready() -> void:
	exit.grab_focus()

func _on_exit_pressed() -> void:
	if get_tree().paused:
		tutorial.visible = false
		get_tree().paused = false
		$"move&attack/Exit".release_focus()
		tube.unpause_texture()
