class_name Room extends Node3D

@onready var door: CSGBox3D = $NavigationRegion3D/walls/door
@onready var npcs: Node3D = $NPCs
@onready var rain_particles: GPUParticles3D = $RainParticles

var width := 10
var length := 10
var id : int = -1

var locked := false
var spawners_active := false
var entered := false

var stats:RoomStats = RoomStats.create()
var stats_mod:RoomStats = RoomStats.create_modifier()
var event := CrawlerManager.EventEnum.NON

var life_init:float
var total_enemies:int
var enemies_left:int = 0

func set_door_visible(value: bool):
	if door != null:
		door.visible = value

func set_NPCs_visible(value: bool):
	if npcs != null:
		npcs.visible = value

func _ready() -> void:
	locked = false
	spawners_active = false
	entered = false
	set_door_visible(true)
	set_NPCs_visible(false)

func check_complete():
	if CrawlerManager.current_enemies <= 0 && enemies_left <= 0:
		#CrawlerManager.current_health += stats.enemies_qty*(CrawlerManager.player.stats.current_health/100)
		CrawlerManager.current_health += stats.enemies_qty
		CrawlerManager.current_scene.health_lbl.text = str(int(CrawlerManager.current_health)) + "%"
		locked = false
		set_NPCs_visible(true)
		spawners_active = false
		CrawlerManager.open_room(id+1)
		CrawlerManager.clear_room(id-2)
		rain_particles.emitting = false

func can_spawn_enemy() -> bool:
	return spawners_active && CrawlerManager.can_spawn_enemy() && enemies_left > 0

func enemy_defeated():
	stats.enemies_qty -= 1

func onEntered():
	CrawlerManager.current_room = self
	if !entered:
		CrawlerManager.current_scene.update_depth_level()
		enemies_left = CrawlerManager.get_enemies_qty()
		CrawlerManager.player.stats = CrawlerManager.get_room_player_stats(event)
		if event == CrawlerManager.EventEnum.QUIMIO:
			rain_particles.emitting = true
		if(id == 2):
			CrawlerManager.current_scene.video_manager.play_inmunoedition()
		life_init = CrawlerManager.player.stats.current_health
		total_enemies = CrawlerManager.room_stats.enemies_qty
		if event != CrawlerManager.EventEnum.NON:
			CrawlerManager.play_event_animation(event)
		CrawlerManager.set_event_label(event)
		set_door_visible(true)
		spawners_active = true
		entered = true
		CrawlerManager.append_room()
		locked = true
