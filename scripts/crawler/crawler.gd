class_name CrawlerRoot extends Node3D

@onready var map: Node3D = $Map
@onready var health_lbl: Label = $Control/Paciente/salud
@onready var event_lbl: Label = $Control/Paciente/evento
@onready var video_manager: VideoManager = $Control/VideoManager
@onready var camera: CameraRig = $CameraRig
@onready var gui: Control = $Control
@onready var tutorial: Control = $Control/Tutorial
@onready var exit_tutorial: Button = $"Control/Tutorial/move&attack/Exit"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CrawlerManager.init(self)
	
func show_tutorial():
	exit_tutorial.grab_focus()
	get_tree().paused = true
	tutorial.visible = true
	if InputHelper.device == "keyboard":
		$"Control/Tutorial/move&attack/keyboard".visible= true
		$"Control/Tutorial/move&attack/xbox".visible = false
	else:
		$"Control/Tutorial/move&attack/keyboard".visible= false
		$"Control/Tutorial/move&attack/xbox".visible = true
