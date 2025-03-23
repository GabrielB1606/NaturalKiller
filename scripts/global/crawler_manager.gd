extends Node

#enums
enum TeamEnum {ALLY_T, ALLY_NK, ENEMY, NEUTRAL}
enum HitReturnEnum {HIT, IMMUNE, DEATH}
enum EventEnum {NON, REM, QUIMIO, RADIO, INM, RSK}

#event related state
var events : Array[RoomStats] = [
	RoomStats.create_modifier(),                      # No event
	RoomStats.create_modifier(),                      # Remission
	RoomStats.create_modifier(0.5, 0, 0.5,  0, -3),   # Quimio
	RoomStats.create_modifier(1.0, 4, 0  ,  0,  0),   # Radio
	RoomStats.create_modifier(0.5, 0, 0  ,  0,  0),   # Inmuno
	RoomStats.create_modifier(1  , 4,-0.5, 10,  3),   # Risk
]

#player related state
var player:PlayerCharacter
var camera_rig:CameraRig

#map related state
var room_prefabs : Array[Resource] = [
	preload("res://scenes/crawler/rooms/room_00.tscn"),
	preload("res://scenes/crawler/rooms/room_01.tscn"),
	preload("res://scenes/crawler/rooms/room_02.tscn"),
	preload("res://scenes/crawler/rooms/room_03.tscn"),
	preload("res://scenes/crawler/rooms/room_04.tscn"),
]
var rooms:Array[Room]

#game related state
var current_health:float = 8.0
var current_enemies:int = 0
var current_map_length:float = 0
var cap_enemies:int = 8
var current_scene:CrawlerRoot
var current_scroller:Node3D
var current_room:Room
var room_stats:RoomStats
var dialoguing:bool = false

var cinematics_played = {
	"intro": false,
	"inmunoedition": false,
	"journey": false
}

func is_locked() -> bool:
	return current_scene.video_manager.is_playing() || current_scroller != null || dialoguing || !player.visible

func goto_scroller():
	if !cinematics_played["journey"]:
		cinematics_played["journey"] = true
		current_scene.video_manager.play_journey()
		return
	current_scroller = load("res://scenes/scroller/HexGame.tscn").instantiate()
	add_child(current_scroller)
	current_scroller.global_position.z = 100
	current_scene.camera.disable()
	current_scene.gui.visible = false

func goto_crawler():
	current_scene.gui.visible = true
	current_scene.camera.make_current()
	if current_scroller:
		remove_child(current_scroller)
		current_scroller.queue_free()
		current_scroller = null

func init(root: CrawlerRoot):
	room_stats = RoomStats.create()
	current_enemies = 0
	current_scene = root
	current_scene.health_lbl.text = str(int(current_health)) + "%"
	rooms = [
		room_prefabs[0].instantiate(),
		get_random_room().instantiate()
	]
	root.map.add_child(rooms[0])
	root.map.add_child(rooms[1])
	rooms[1].global_position.z -= rooms[0].length
	current_map_length = rooms[0].length + rooms[1].length
	rooms[0].id = 0
	rooms[1].id = 1
	rooms[0].set_NPCs_visible(true)
	rooms[1].set_door_visible(false)

#func restart( t_scene)

func open_room(id: int):
	if id < rooms.size():
		rooms[id].set_door_visible(false)

func clear_room(room_id:int):
	if room_id<0 || room_id>=rooms.size():
		return
	rooms[room_id].queue_free()

func append_room():
	var room : Room = get_random_room().instantiate()
	var roll :float= randf_range(0, 100)
	
	if roll <= current_health/2.0 && rooms.size()>2:
		room.event = CrawlerManager.EventEnum.REM
	elif roll < 50.0 && rooms.size()>2:
		var ev:EventEnum = randi_range(2,5)
		room.event = ev
		room.stats_mod = events[ev]
	else:
		room.stats_mod = events[0]
	
	room.stats.enemies_qty = room_stats.enemies_qty
	
	room.id = rooms.size()
	rooms.append(room)
	current_scene.add_child(room)
	room.global_position.z -= current_map_length
	current_map_length += room.length
	
	room_stats.enemies_ad += 10
	room_stats.enemies_hp += 10
	room_stats.enemies_mv += 0.25
	room_stats.enemies_qty += 2

func get_enemies_hp():
	return room_stats.enemies_hp + events[current_room].enemies_hp

func get_enemies_ad():
	return room_stats.enemies_ad + events[current_room].enemies_ad

func get_enemies_mv():
	return room_stats.enemies_mv + events[current_room].enemies_mv

func get_spwn_freq():
	return room_stats.spwn_freq + events[current_room].spwn_freq

func get_time_mult():
	return room_stats.time_mult + events[current_room].time_mult

func play_event_animation(event):
	current_scene.video_manager.play_event(event)
	
func set_event_label(event):
	match event:
		EventEnum.QUIMIO:
			current_scene.event_lbl.text = "Quimioterapia"
		EventEnum.RADIO:
			current_scene.event_lbl.text = "Radioterapia"
		EventEnum.INM:
			current_scene.event_lbl.text = "Inmunoterapia"
		EventEnum.RSK:
			current_scene.event_lbl.text = "Factor de Riesgo"
		_:
			current_scene.event_lbl.text = "--"

func get_random_room() -> Resource:
	return room_prefabs[randi_range(1, 4)]

func can_spawn_enemy() -> bool:
	return current_enemies < cap_enemies && !is_locked()

func set_player(_player):
	player = _player

func set_camera_rig(_cam):
	camera_rig = _cam
