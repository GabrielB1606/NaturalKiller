class_name Tube extends Node3D

@onready var tube: Node3D = $"."
const rotation_speed := 5.0
@onready var grid: MeshInstance3D = $Grid

func pause_texture():
	grid.material_override.set_shader_parameter("delta_time", 0)

func unpause_texture():
	grid.material_override.set_shader_parameter("delta_time", 0.017)

func _physics_process(delta: float) -> void:
	var direction := -Input.get_axis("left", "right")

	if direction:
		tube.rotate_y(rotation_speed * delta * direction)
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("left"):
		#tube.rotate_y(10.0)
	#pass
