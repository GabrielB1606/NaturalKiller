extends CharacterState

@onready var cell: Cell = $"../../Visuals/Cell"
@onready var player: PlayerCharacter = $"Player"
@onready var character: CharacterBody3D = $"../.."

var incline:float=0.5
var offset:Vector3=Vector3(0,0,0.25)

# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	cell.set_arms("agony")
	cell.translate(offset)
	cell.rotate_x(incline)

func _exit() -> void:
	cell.rotate_x(-incline)
	cell.translate(-offset)
