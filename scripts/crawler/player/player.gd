class_name PlayerCharacter
extends CharacterBody3D

@onready var camera_point: Node3D = $CameraPoint
@onready var character: Node3D = $Visuals
@onready var cell: Cell = $Visuals/Cell
@onready var hold_area: Area3D = $Visuals/HoldArea
@onready var head_hb: Area3D = $Visuals/HeadHB

@onready var mov_state_machine: CharacterStateMachine = $MovementStateMachine
@onready var fight_state_machine: CharacterStateMachine = $FightingStateMachine

@export var camera_rig:Node3D
@export var stats:CharacterStats

@export var body_held:CharacterBody3D = CharacterBody3D.new()
@onready var dead_menu: Control = $"../Control/DeadMenu"

var lifetime:float = 0.0

func set_cell_type(type):
	cell.type = type
	cell.update_type()

func set_body_held(body: CharacterBody3D) -> void:
	body_held = body

func get_mouse_world_position(mouse:Vector2) -> Vector3:
	var distance = 1000
	var camera:Camera3D = camera_rig.background_cam
	var space:=get_world_3d().direct_space_state
	var o = camera.project_ray_origin(mouse)
	var params = PhysicsRayQueryParameters3D.new()
	params.from = o
	params.to = o + (camera.project_ray_normal(mouse)*distance)
	var intersection := space.intersect_ray(params)
	if intersection.is_empty():
		return Vector3.ZERO
	else:
		return intersection.position

func receive_hit(source: NPCharacter) -> float :
	stats.current_health -= source.stats.current_attack_damage
	return stats.current_health

func _ready() -> void:
	mov_state_machine.init(self)
	fight_state_machine.init(self)
	stats = CrawlerManager.character_stats[ CrawlerManager.current_player_cell_type ]
	#stats = CharacterStats.create(5.0, 4.5, 100.0, 25.0)
	CrawlerManager.set_player(self)
	cell.onAttack = func check_hit() -> void:
		if head_hb.has_overlapping_bodies():
			var hit = false
			for b in head_hb.get_overlapping_bodies():
				if b is NPCharacter:
					var hit_return = b.receive_hit(self)
					if hit_return <= 0:
						cell.emit_attack_particles() 
						if body_held == b:
							body_held = null
							fight_state_machine.dispatch("to_idle")
							stats.current_health = min(stats.current_health+10, stats.base_health)
					hit = true
			if hit:
				CrawlerManager.camera_rig.set_trauma(0.75)

func attack():
	cell.trigger_attack()
	
func _input(event: InputEvent) -> void:
	if CrawlerManager.is_locked():
		return
	
	var mov_input := Input.get_vector("left", "right", "forward", "backward")
	var movement_vector := (transform.basis * Vector3(mov_input.x, 0, mov_input.y)).normalized()
	
	var look_input := Input.get_vector("look_left", "look_right", "look_forward", "look_backward")
	var look_vector :Vector3
	if InputHelper.device == "keyboard":
		look_vector = get_mouse_world_position( get_viewport().get_mouse_position() )
		look_vector = look_vector - global_position 
		look_vector.y = 0
	elif !look_input.is_zero_approx():
		look_vector = (transform.basis * Vector3(look_input.x, 0, look_input.y)).normalized()
	
	if event.is_action_pressed("hit"):
		attack()
	
	mov_state_machine.onInput(event, movement_vector, look_vector)
	fight_state_machine.onInput(event, movement_vector, look_vector)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	mov_state_machine.onPhysicsProcess(delta)
	fight_state_machine.onPhysicsProcess(delta)
	move_and_slide()

func _process(delta: float) -> void:
	if CrawlerManager.current_enemies > 0:
		lifetime += delta
		stats.current_health -= delta*CrawlerManager.get_time_mult()
	if stats.current_health <= 0:
		CrawlerManager.death()
		dead_menu.handleDeath()
