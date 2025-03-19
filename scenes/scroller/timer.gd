extends Control

@onready var s_lbl: Label = $Seconds
@onready var ms_lbl: Label = $Milliseconds

var time:float = 0.0
var total:float = 15.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	s_lbl.text = str(int(total - time))
	if time >= 15:
		get_tree().change_scene_to_file("res://scenes/crawler/Crawler.tscn")
