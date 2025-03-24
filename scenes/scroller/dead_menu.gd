extends Control

@onready var dead_menu: Control = $"."
@onready var tcell: Button = $HBoxContainer/tcell
@onready var nk: Button = $HBoxContainer/nk
@onready var tcellqty: Label = $Label2

var showing : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dead_menu.hide()

func handleDeath():
	dead_menu.show()
	if !showing:
		showing = true
		CrawlerManager.player.visible = false
		nk.grab_focus()
		tcell.disabled = CrawlerManager.current_tcell_qty <= 0
		tcellqty.text = "(" + str(CrawlerManager.current_tcell_qty) +" disponibles)"
	#get_tree().paused = true

func _on_exit_pressed() -> void:
	dead_menu.hide()
	showing = false
	#get_tree().paused = false
	CrawlerManager.player.visible = true
	CrawlerManager.current_tcell_qty -= 1
	CrawlerManager.current_player_cell_type = CrawlerManager.TeamEnum.ALLY_T
	get_tree().reload_current_scene()


func _on_restart_pressed() -> void:
	dead_menu.hide()
	showing = false
	CrawlerManager.player.visible = true
	CrawlerManager.current_player_cell_type = CrawlerManager.TeamEnum.ALLY_NK
	#get_tree().paused = false
	get_tree().reload_current_scene()
