extends Node3D

@onready var tube: Node3D = $"."
const rotation_speed := 5.0

func _physics_process(delta: float) -> void:
	var direction := -Input.get_axis("left", "right")
	#var mat:ShaderMaterial = material_override
	#mat.set_shader_parameter("delta_time", delta)
	if direction:
		tube.rotate_y(rotation_speed * delta * direction)
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("left"):
		#tube.rotate_y(10.0)
	#pass
