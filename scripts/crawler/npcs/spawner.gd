class_name Spawner extends Node3D

var enemyPrefab = preload("res://scenes/crawler/npcs/Enemy.tscn")

@onready var timer: Timer = $Timer
@export var room:Room

func _ready() -> void:
	timer.wait_time = randf_range(1, 2)
	timer.start()

func _on_timer_timeout() -> void:
	if room.can_spawn_enemy():
		var obj = enemyPrefab.instantiate()
		add_child(obj)
		obj.room = room
		CrawlerManager.current_enemies += 1
		room.enemies_left -= 1
	timer.wait_time = randf_range(1, 2)
	timer.start()
