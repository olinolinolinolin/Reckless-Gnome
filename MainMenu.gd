extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/NewGameButton.grab_focus()
	GlobalVariables.load_scores()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalVariables.hassave == true:
		$VBoxContainer/LoadGameButton.show()


func _on_new_game_button_pressed():
	GlobalVariables.NewSave()
	get_tree().change_scene_to_file("res://MapScreen.tscn")


func _on_quit_button_pressed():
	get_tree().quit()


func _on_load_game_button_pressed():
	get_tree().change_scene_to_file("res://MapScreen.tscn")
