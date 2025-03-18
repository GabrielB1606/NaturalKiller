class_name Cell
extends Node3D

@export var animationOffset := 0.0
@export var type := CrawlerManager.TeamEnum.ALLY
@onready var animation_tree: AnimationTree = $AnimationTree
@export var onAttack:Callable
@onready var hit_particles: ParticleGroup = $HitParticles

func emit_attack_particles() -> void:
	hit_particles.emit()

func on_enemy_hit():
	if onAttack:
		onAttack.call()

func set_legs(running_value:float):
	animation_tree.set("parameters/lower_body/blend_position", running_value)

func set_arms(state: String):
	animation_tree.get("parameters/upper_body/playback").travel(state)

func trigger_attack():
	if !animation_tree.get("parameters/OneShot/active"):
		animation_tree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if type == CrawlerManager.TeamEnum.ENEMY:
		var head_mat : StandardMaterial3D = get_node("Skeleton3D/mesh/head_tcell_int_002").material_override
		head_mat = head_mat.duplicate()
		head_mat.albedo_color = Color(1, 0, 0, 0.75)
		var head_node: MeshInstance3D = get_node("Skeleton3D/mesh/head_tcell_int_002")
		head_node.material_override = head_mat


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
