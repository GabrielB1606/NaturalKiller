class_name VideoManager extends Control

const INTRO = preload("res://assets/videos/intro.ogv")
const EDICION = preload("res://assets/videos/edicion.ogv")
const INMUNO = preload("res://assets/videos/inmuno.ogv")
const QUIMIO = preload("res://assets/videos/quimio.ogv")
const RADIO = preload("res://assets/videos/radio.ogv")
const REMISION = preload("res://assets/videos/remision.ogv")
const RSK = preload("res://assets/videos/rsk.ogv")
const VIAJE = preload("res://assets/videos/viaje.ogv")

@onready var player: VideoStreamPlayer = $Player

var ending :bool= false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !CrawlerManager.cinematics_played["intro"]:
		CrawlerManager.cinematics_played["intro"] = true
		player.stream = INTRO
		player.play()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("skip") && !ending:
		if player.stream == VIAJE:
			CrawlerManager.goto_scroller()
		elif player.stream == INTRO && player.is_playing():
			CrawlerManager.current_scene.show_tutorial()
		stop()

func stop():
	player.stop()

func is_playing() -> bool:
	return player.is_playing()

func play_event(event):
	match event:
		CrawlerManager.EventEnum.QUIMIO:
			player.stream =QUIMIO
		CrawlerManager.EventEnum.RADIO:
			player.stream = RADIO
		CrawlerManager.EventEnum.INM:
			player.stream = INMUNO
		CrawlerManager.EventEnum.RSK:
			player.stream = RSK
		CrawlerManager.EventEnum.REM:
			ending = true
			player.stream = REMISION
	player.play()

func play_journey():
	player.stream = VIAJE
	player.play()

func play_inmunoedition():
	if !CrawlerManager.cinematics_played["inmunoedition"]:
		CrawlerManager.cinematics_played["inmunoedition"] = true
		player.stream = EDICION
		player.play()

func _on_player_finished() -> void:
	if ending:
		ending = false
		get_tree().change_scene_to_file("res://scenes/gui/main_menu.tscn")
	elif player.stream == VIAJE:
		CrawlerManager.goto_scroller()
	elif player.stream == INTRO:
		CrawlerManager.current_scene.show_tutorial()
