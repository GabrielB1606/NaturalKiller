class_name DendriticCell extends Node3D

const test_dialogue = preload("res://dialogues/test.dialogue")
var player_in := false
const first_dend = preload("res://dialogues/first_dend.dialogue")

func interact():
	if CrawlerManager.current_room.id == 0:
		DialogueManager.show_example_dialogue_balloon(first_dend, "start")
	else:
		DialogueManager.show_example_dialogue_balloon(test_dialogue, "start")
	CrawlerManager.dialoguing = true


func _on_interaction_area_body_entered(body) -> void:
	if body is PlayerCharacter:
		player_in = true
	

func _on_interaction_area_body_exited(body) -> void:
	if body is PlayerCharacter:
		player_in = false

func _input(event: InputEvent) -> void:
	if !CrawlerManager.is_locked() && CrawlerManager.current_enemies <= 0 && player_in && event.is_action_pressed("interact"):
		interact()
