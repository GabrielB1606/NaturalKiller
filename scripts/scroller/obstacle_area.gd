extends Area3D

@onready var timer: Timer = $Timer
var velocity := 10.0
var points_label:Label
var glob_timer:Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if glob_timer && glob_timer.time <=13:
		position.z += delta*velocity
		if position.z > 40:
			queue_free()


func _on_body_entered(body: Node3D) -> void:
	points_label.text = str( int(points_label.text)-1 )
	queue_free()
	pass # Replace with function body.
