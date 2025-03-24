extends Control

@onready var dungeon_crawler: Button = $"Main/Dungeon Crawler"
@onready var main: VBoxContainer = $Main
@onready var dificultad: VBoxContainer = $Dificultad
@onready var mid: Button = $Dificultad/mid


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dungeon_crawler.grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_infinite_scroller_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/scroller/HexGame.tscn")


func _on_dungeon_crawler_pressed() -> void:
	dificultad.visible = true
	main.visible = false
	
	mid.grab_focus()
	#get_tree().change_scene_to_file("res://scenes/crawler/Crawler.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_back_pressed() -> void:
	dungeon_crawler.grab_focus()
	dificultad.visible = false
	main.visible = true


func _on_ez_pressed() -> void:
	CrawlerManager.current_difficulty = CrawlerManager.DifficultyEnum.EASY
	CrawlerManager.current_health = 30
	get_tree().change_scene_to_file("res://scenes/crawler/Crawler.tscn")


func _on_mid_pressed() -> void:
	CrawlerManager.current_difficulty = CrawlerManager.DifficultyEnum.MID
	CrawlerManager.current_health = 20
	get_tree().change_scene_to_file("res://scenes/crawler/Crawler.tscn")

func _on_hard_pressed() -> void:
	CrawlerManager.current_difficulty = CrawlerManager.DifficultyEnum.HARD
	CrawlerManager.current_health = 10
	get_tree().change_scene_to_file("res://scenes/crawler/Crawler.tscn")
	
