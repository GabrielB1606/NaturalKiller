class_name NPCharacter
extends CharacterBody3D

@onready var player: PlayerCharacter
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var mov_state_machine: MovementCharacterStateMachine = $MovementStateMachine
@onready var fight_state_machine: LimboHSM = $FightingStateMachine
@onready var character: Node3D = $Visuals
@onready var cell: Cell = $Visuals/Cell
@onready var head_hb: Area3D = $Visuals/HeadHB

@export var stats:CharacterStats

const JUMP_VELOCITY = 4.5
var movement_input := Vector3.ZERO
var looking_at := Vector3.ZERO
var reach_range := 4
var attack_range := 1.25
var held = false
var room:Room

func receive_hit(source: PlayerCharacter) -> float :
	stats.current_health -= source.stats.current_attack_damage
	if stats.current_health <= 0:
		CrawlerManager.current_enemies-=1
		room.check_complete()
		queue_free()
	return stats.current_health

func _ready() -> void:
	player = CrawlerManager.player
	stats = CharacterStats.create(3.0, 4.5, 100.0, 20.0)
	mov_state_machine.init(self)
	fight_state_machine.init(self)
	cell.onAttack = func attack() -> void:
		var hit = false
		for b in head_hb.get_overlapping_bodies():
			if b is PlayerCharacter:
				hit = true
				b.receive_hit(self)
		if hit:
			CrawlerManager.camera_rig.set_trauma(0.5)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity = Vector3.ZERO
	
	var distance_from_player := character.global_position.distance_squared_to(player.global_position)
	if held:
		var hold_area:Area3D = player.get_node("Visuals/HoldArea")
		global_position.x = hold_area.global_position.x
		global_position.z = hold_area.global_position.z
		global_rotation.y = hold_area.global_rotation.y
		fight_state_machine.dispatch("to_captured")
	elif distance_from_player >= attack_range*attack_range:
		nav_agent.set_target_position(player.global_transform.origin)
		var next_nav_point = nav_agent.get_next_path_position()
		velocity = (next_nav_point - global_transform.origin).normalized() * stats.current_speed
		if distance_from_player <= reach_range*reach_range:
			fight_state_machine.dispatch("to_reach")
		else:
			fight_state_machine.dispatch("to_passive")
		movement_input = velocity
		rotation.y = lerp_angle( rotation.y, atan2(velocity.x, velocity.z), delta*10.0 )
	else:
		cell.trigger_attack()
		fight_state_machine.dispatch("to_hold")
		
	mov_state_machine.get_active_state().onPhysicsProcess(delta)
	fight_state_machine.get_active_state().onPhysicsProcess(delta)
	#looking_at = global_position + movement_input
	#looking_at.y = 0
	#character.look_at(looking_at)
	move_and_slide()
