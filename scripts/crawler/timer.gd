extends Control

@onready var s_lbl: Label = $Seconds
@onready var ms_lbl: Label = $Milliseconds
@onready var player: PlayerCharacter = %Player

var time:float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	s_lbl.text = str(int(player.stats.current_health))
