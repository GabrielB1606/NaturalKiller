extends Room

@onready var spawner: Spawner = $Spawner
@onready var spawner_2: Spawner = $Spawner2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	length = 15.25
	super._ready()

func _on_enter_area_area_entered(area: Area3D) -> void:
	onEntered()
