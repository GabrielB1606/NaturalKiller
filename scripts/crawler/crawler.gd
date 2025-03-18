class_name CrawlerRoot extends Node3D

@onready var map: Node3D = $Map

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CrawlerManager.init(self)
