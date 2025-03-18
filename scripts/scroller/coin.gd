extends Area3D

@onready var timer: Timer = $Timer
var velocity := 10.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.z += delta*velocity
	if position.z > 40:
		queue_free()
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_body_entered(body: Node3D) -> void:
	print("+1")
	queue_free()
	pass # Replace with function body.
