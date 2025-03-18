extends Node3D

@onready var ray: RayCast3D = $"../RayCast3D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ray.target_position = position
