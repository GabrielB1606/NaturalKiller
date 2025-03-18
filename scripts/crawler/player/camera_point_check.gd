extends RayCast3D

@onready var player: CharacterBody3D = $".."

func _ready() -> void:
	add_exception(player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var collider := get_collider()
	if collider is CSGBox3D && collider != null && collider.get_layer_mask_value(1):
		collider.set_layer_mask_value(2, true)
		collider.set_layer_mask_value(1, false)
