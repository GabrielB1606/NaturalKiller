extends Control

@onready var dead_menu: Control = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dead_menu.hide()

func handleDeath():
	dead_menu.show()
	get_tree().paused = true

func _on_exit_pressed() -> void:
	dead_menu.hide()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/gui/main_menu.tscn")


func _on_restart_pressed() -> void:
	dead_menu.hide()
	get_tree().paused = false
	get_tree().reload_current_scene()
