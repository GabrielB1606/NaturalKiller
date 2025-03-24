extends Node3D

var obstacle = preload("res://scenes/scroller/Obstacle.tscn")
var coin = preload("res://scenes/scroller/Coin.tscn")
@onready var spawn_timer: Timer = $SpawnTimer
const rotation_speed := 5.0
@onready var points_label: Label = $"../Control/Timer/Points"
@onready var player: Node3D = $"../Player"
@onready var timer: Control = $"../Control/Timer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction := -Input.get_axis("left", "right")
	if direction:
		rotate_y(rotation_speed * delta * direction)
	if timer.time >= 13:
		player.position.y -= delta*5


func _on_spawn_timer_timeout() -> void:
	
	var obj_prob := randf_range(0, 1)
	var obj
	
	if obj_prob <= 0.7:
		obj = obstacle.instantiate()
	else:
		obj = coin.instantiate()
		
	obj.points_label = points_label
	obj.glob_timer = $"../Control/Timer"
	
	#obs.position.y += 3.5
	var r := 3.5
	var x := randf_range(-r, r)
	var y := sqrt((r*r)-(x*x))
	obj.position.x += x
	if randi_range(0, 1):
		obj.position.y -= y
	else:
		obj.position.y += y
		
	#print(obs.position)
	add_child(obj)
	spawn_timer.wait_time = randf_range(0.125, 1)
	if $"../Control/Timer".time <= 13:
		spawn_timer.start()
	else:
		$"../test_tube2_culling_fix".pause_texture()
