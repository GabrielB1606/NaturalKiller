class_name CrawlerRoot extends Node3D

@onready var map: Node3D = $Map
@onready var health_lbl: Label = $Control/Paciente/salud
@onready var event_lbl: Label = $Control/Paciente/evento
@onready var video_manager: VideoManager = $Control/VideoManager
@onready var camera: CameraRig = $CameraRig
@onready var gui: Control = $Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CrawlerManager.init(self)
