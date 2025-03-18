extends Node

enum TeamEnum {ALLY, ENEMY, NEUTRAL}
enum HitReturnEnum {HIT, IMMUNE, DEATH}

var player:PlayerCharacter
var camera_rig:CameraRig
var current_enemies:int = 0
var current_map_length:float = 0
var cap_enemies:int = 8
var current_scene:CrawlerRoot

var room00_prefab := preload("res://scenes/crawler/rooms/room_00.tscn")
var room01_prefab := preload("res://scenes/crawler/rooms/room_01.tscn")
var room02_prefab := preload("res://scenes/crawler/rooms/room_02.tscn")
var room03_prefab := preload("res://scenes/crawler/rooms/room_03.tscn")
var room04_prefab := preload("res://scenes/crawler/rooms/room_04.tscn")

var rooms:Array[Room]
const room_gap := 0

func init(root: CrawlerRoot):
	current_enemies = 0
	current_scene = root
	rooms = [
		room00_prefab.instantiate(),
		get_random_room().instantiate()
	]
	root.map.add_child(rooms[0])
	root.map.add_child(rooms[1])
	rooms[1].global_position.z -= rooms[0].length - room_gap
	current_map_length = rooms[0].length + rooms[1].length - room_gap
	rooms[0].id = 0
	rooms[1].id = 1
	rooms[1].set_door_visible(false)

func open_room(id: int):
	if id < rooms.size():
		rooms[id].set_door_visible(false)

func clear_room(room_id:int):
	if room_id<0 || room_id>=rooms.size():
		return
	rooms[room_id].queue_free()

func append_room():
	var room : Room = get_random_room().instantiate()
	room.id = rooms.size()
	rooms.append(room)
	current_scene.add_child(room)
	room.global_position.z -= current_map_length - room_gap
	current_map_length += room.length - room_gap

func get_random_room() -> Resource:
	var vec := [room01_prefab, room02_prefab, room03_prefab, room04_prefab]
	return vec[randi_range(0, 3)]

func can_spawn_enemy() -> bool:
	return current_enemies < cap_enemies

func set_player(_player):
	player = _player

func set_camera_rig(_cam):
	camera_rig = _cam
