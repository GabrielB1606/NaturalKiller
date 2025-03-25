class_name CameraRig
extends Node3D

#@onready var background_viewport: SubViewport = $Base/backgroundViewportContainer/backgroundViewport
#@onready var foreground_viewport: SubViewport = $Base/foregroundViewportContainer/foregroundViewport
#
#@onready var background_cam: Camera3D = $Base/backgroundViewportContainer/backgroundViewport/backgroundCam
#@onready var foreground_cam: Camera3D = $Base/foregroundViewportContainer/foregroundViewport/foregroundCam
@onready var base: Camera3D = $Base

@export var shake_props = {
	decay = 2.0,
	max_offset = Vector2(0.25, 0.125),
	max_roll = 0.1,
	trauma = 0.0,
	trauma_power = 2
}

func set_trauma(value: float = 1.0) -> void:
	shake_props.trauma = value

func shake() -> void:
	if CrawlerManager.is_locked():
		return
	var amount = pow(shake_props.trauma, shake_props.trauma_power)
	var rot = shake_props.max_roll * amount * randf_range(-1, 1)
	var offset_x = shake_props.max_offset.x * amount * randf_range(-1, 1)
	var offset_y = shake_props.max_offset.y * amount * randf_range(-1, 1)
	
	$Base.position.x += offset_x
	$Base.position.y += offset_y
	$Base.rotation.z += rot
	
	#background_cam.position.x += offset_x
	#foreground_cam.position.x += offset_x
	#background_cam.position.y += offset_y
	#foreground_cam.position.y += offset_y
	#background_cam.rotation.z += rot
	#foreground_cam.rotation.z += rot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#resize()
	CrawlerManager.set_camera_rig(self)

func resize() -> void:
	pass
	#background_viewport.size = DisplayServer.window_get_size()
	#foreground_viewport.size = DisplayServer.window_get_size()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#background_cam.global_transform = CrawlerManager.player.camera_point.global_transform
	#foreground_cam.global_transform = CrawlerManager.player.camera_point.global_transform
	$Base.global_transform = CrawlerManager.player.camera_point.global_transform
	if shake_props.trauma > 0.0:
		shake_props.trauma = max(0, shake_props.trauma - (shake_props.decay*delta))
		shake()

func disable():
	$Base.visible = false
	#$Base/backgroundViewportContainer.visible = false
	#$Base/foregroundViewportContainer.visible = false

func make_current():
	#$Base/backgroundViewportContainer.visible = true
	#$Base/foregroundViewportContainer.visible = true
	$Base.make_current()
