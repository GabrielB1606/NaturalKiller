class_name Room extends Node3D

@onready var door: CSGBox3D = $NavigationRegion3D/walls/door

var width := 10
var length := 10
var enemies_left := 10
var id : int = -1

var locked := false
var spawners_active := false
var entered := false

func set_door_visible(value: bool):
	if door != null:
		door.visible = value

func _ready() -> void:
	locked = false
	spawners_active = false
	entered = false
	enemies_left = 10
	set_door_visible(false)

func check_complete():
	if CrawlerManager.current_enemies <= 0 && enemies_left <= 0:
		locked = false
		set_door_visible(false)
		spawners_active = false

func can_spawn_enemy() -> bool:
	return spawners_active && CrawlerManager.can_spawn_enemy() && enemies_left > 0

func enemy_defeated():
	enemies_left -= 1

func onEntered():
	if !entered:
		set_door_visible(true)
		spawners_active = true
		entered = true
		CrawlerManager.append_room()
		locked = true
