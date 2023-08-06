extends Control
var leveltoenter = null
var specialcode = []
var specialcodeactivated = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Map1.grab_focus()
	GlobalVariables.load_scores()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalVariables.FurthestLevel > 1:
		$Map2.show()
	if GlobalVariables.FurthestLevel > 2:
		$Map3.show()
	if GlobalVariables.FurthestLevel > 3:
		$Map4.show()
	if GlobalVariables.FurthestLevel > 4:
		$Map5.show()
	if GlobalVariables.FurthestLevel > 5:
		$MapBoss.show()
	if specialcode.size() > 10:
		specialcode.pop_front()
	if leveltoenter != null:
		$EnterLevelButton.show()
	if Input.is_action_just_pressed("Up"):
		specialcode.append("up")
	if Input.is_action_just_pressed("Down"):
		specialcode.append("down")
	if Input.is_action_just_pressed("Left"):
		specialcode.append("left")
	if Input.is_action_just_pressed("Right"):
		specialcode.append("right")
	if Input.is_action_just_pressed("NotKojumble"):
		specialcode.append("A")
	if Input.is_action_just_pressed("Kojumble"):
		specialcode.append("B")
	if specialcode == ["up", "up", "down", "down", "left", "right", "left", "right", "B", "A"]:
		if specialcodeactivated == false:
			if GlobalVariables.CoinsCollected == [true,true,true,true,true,true]:
				specialcodeactivated = true
				$Gnomeeeee.play()
				print_debug("Civic Moment")
				$SecretButton.show()
func _on_map_1_pressed():
	leveltoenter = "res://TestingArea.tscn"


func _on_enter_level_button_pressed():
	get_tree().change_scene_to_file(leveltoenter)


func _on_map_2_pressed():
	leveltoenter = "res://Level2.tscn"


func _on_go_back_button_pressed():
	get_tree().change_scene_to_file("res://MainMenu.tscn")


func _on_map_3_pressed():
	leveltoenter = "res://Level3.tscn"


func _on_map_4_pressed():
	leveltoenter = "res://Level4.tscn"


func _on_map_5_pressed():
	leveltoenter = "res://Level5.tscn"
	
func _on_map_boss_pressed():
	leveltoenter = "res://Level6.tscn"


func _on_secret_button_pressed():
	leveltoenter = "res://Secret/2006Civic.tscn"
