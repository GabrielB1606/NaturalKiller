extends Room

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	length = 16
	super._ready()

func _on_enter_area_area_entered(area: Area3D) -> void:
	onEntered()
