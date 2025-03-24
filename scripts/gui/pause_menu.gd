extends Control

@onready var pause_menu: Control = $"."
@onready var resume: Button = $HBoxContainer/Resume

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_menu.hide()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		handlePause()

func handlePause():
	if get_tree().paused:
		pause_menu.hide()
	else:
		pause_menu.show()
		resume.grab_focus()
	get_tree().paused = !(get_tree().paused)


func _on_exit_pressed() -> void:
	handlePause()
	get_tree().change_scene_to_file("res://scenes/gui/main_menu.tscn")
