extends Node3D

var tcell = preload("res://characters/Cell.tscn")
@onready var player: Node3D = $Player
@onready var front: Node3D = $Player/CharacterBody3D/front
@onready var back: Node3D = $Player/CharacterBody3D/back
var random = RandomNumberGenerator.new()
const modelScale := 1

func spawnTCell(idx) -> void:
	random.randomize()
	var r := 1.75
	var z := random.randf_range(0, 3)
	var x := random.randf_range(-1.25, 1.25)
	var y := -sqrt((r*r)-(x*x))
	var obj := tcell.instantiate()
	obj.animationOffset = randf_range(0, 2)
	obj.position = Vector3(x, y, z)
	obj.scale = Vector3(modelScale,modelScale,modelScale)
	player.add_child(obj)
	#obj.get_node("AnimationPlayer").play("run")
	#obj.get_node("AnimationPlayer").seek(obj.animationOffset)
	obj.set_legs(1)
	obj.set_arms("run")
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	back.set_legs(1)
	back.set_arms("run")
	front.set_legs(1)
	front.set_arms("run")
	for i in 6:
		spawnTCell(i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
