extends Label
var m = 0
var s = 0
var ms = 0
var scorems = 0
var finishedtime = ""
signal finishtime
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var minutes = (scorems / 600)
	var seconds = (scorems / 10) % 60
	var milliseconds = scorems % 10
	$".".text = "Time: {m}:{s}.{ms}".format({"m":minutes,"s":seconds,"ms":milliseconds})
	finishedtime = scorems


func _on_timer_timeout():
	ms += 1
	scorems += 1

func stoptimer(LevelBeat):
	if LevelBeat == true:
		finishtime.emit(finishedtime)
	$Timer.stop()
