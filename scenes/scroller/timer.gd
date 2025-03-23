extends Control

@onready var s_lbl: Label = $Seconds
@onready var ms_lbl: Label = $Milliseconds
@onready var progress_bar: TextureProgressBar = $ProgressBar

var time:float = 0.0
var total:float = 15.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	s_lbl.text = str(int(total - time))
	var value := (time/total)*100
	progress_bar.value = value
	
	if time >= total:
		CrawlerManager.goto_crawler()
