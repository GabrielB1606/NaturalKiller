extends Control

@onready var s_lbl: Label = $Seconds
@onready var ms_lbl: Label = $Milliseconds
@onready var progress_bar: TextureProgressBar = $ProgressBar
@onready var points: Label = $Points

var time:float = 0.0
var total:float = 15.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	s_lbl.text = str(int(total - time))
	var value := (time/total)*100
	progress_bar.value = value
	
	if time >= total:
		CrawlerManager.current_tcell_qty += max(0, int(points.text))
		CrawlerManager.goto_crawler()
