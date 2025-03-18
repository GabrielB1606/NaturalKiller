class_name CharacterStats extends Resource

@export var base_speed:float = 5.0
@export var base_jump_velocity:float = 4.5
@export var base_health:float = 100.0
@export var base_attack_damage:float = 25.0

@export var current_speed:float = base_speed
@export var current_jump_velocity:float = base_jump_velocity
@export var current_health:float = base_health
@export var current_attack_damage:float = base_attack_damage

static func create(
	speed: float = 3.5,
	jump_velocity: float = 4.5,
	health: float = 100.0,
	attack_damage: float = 25.0
) -> CharacterStats:
	var instance = CharacterStats.new()
	
	instance.base_health = health
	instance.current_health = health
	
	instance.base_jump_velocity = jump_velocity
	instance.current_jump_velocity = jump_velocity
	
	instance.base_speed = speed
	instance.current_speed = speed

	instance.base_attack_damage = attack_damage
	instance.current_attack_damage = attack_damage
	
	return instance
