extends Area3D

@onready var timer: Timer = $Timer
var velocity := 10.0
@export var dead_menu : Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.z += delta*velocity
	if position.z > 40:
		queue_free()
	


func _on_body_entered(body: Node3D) -> void:
	dead_menu.handleDeath()
	#print("gg")
	#timer.start()


func _on_timer_timeout() -> void:
	pass
	#print("wp")
	#get_tree().reload_current_scene()
