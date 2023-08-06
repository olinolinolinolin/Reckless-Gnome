extends Sprite2D
@export var LevelName = " "
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_goal_post_check_body_entered(body):
	if body.is_in_group("Player"):
		body.LevelBeat()
		body.IdentifyLevel(LevelName)
		body.StopTimer()
		print_debug("Split" + LevelName + " Finished")
