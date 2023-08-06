extends Node2D
@onready var GnomeBody = $GnomeBody
@onready var BikeBody = $BikeBody
var wheels = []
var bodyparts = []
var grounded = false
var rng = RandomNumberGenerator.new()
var speed = 1000
var maxspeed = 70
var driving = true
var score = 0
var paused = false
var levelcomplete = false
var LevelImOn = ""
var BestTime = null
var NewBestTime = false
var Sounds = [preload("res://Audio/CoinCollected.wav"), preload("res://Audio/Completion1.wav"), preload("res://Audio/Completion2.wav"), preload("res://Audio/Completion3.wav"), preload("res://Audio/Completion4.wav"), 
preload("res://Audio/GnomeHurt1.wav"), preload("res://Audio/GnomeHurt2.wav"), preload("res://Audio/GnomeHurt3.wav"), preload("res://Audio/GnomeHurt4.wav"), preload("res://Audio/NewBestTime1.wav"), preload("res://Audio/NewBestTime2.wav"), preload("res://Audio/NewBestTime3.wav"), preload("res://Audio/NewBestTime4.wav"), 
preload("res://Audio/NewBestTime5.wav"), preload("res://Audio/Thud1.wav"), preload("res://Audio/Thud2.wav")]
@onready var GnomeRagdoll = "res://Gnomeragdoll.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	GlobalVariables.load_scores()
	wheels = get_tree().get_nodes_in_group("Wheel")
	bodyparts = get_tree().get_nodes_in_group("BodyPart")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if BestTime != null:
		var minutes = (BestTime / 600)
		var seconds = (BestTime / 10) % 60
		var milliseconds = BestTime % 10
		$GnomeBody/CanvasLayer/Control/YouDidIt/VBoxContainer/BestTimeLabel.text = "Time: {m}:{s}.{ms}".format({"m":minutes,"s":seconds,"ms":milliseconds})
	if driving == true and Input.is_action_pressed("Forward"):
		for wheel in wheels:
			if wheel.angular_velocity < maxspeed:
				wheel.apply_torque_impulse(speed * delta * 30)
	if driving == true and Input.is_action_pressed("Backward"):
		for wheel in wheels:
			if wheel.angular_velocity > -maxspeed:
				wheel.apply_torque_impulse(-speed * delta * 30)
	if $BikeBody/JumpCheck.get_collider() != null:
		grounded = true
	$BikeBody.apply_force(Vector2(200,0), Vector2(0,0))
	if Input.is_action_just_pressed("Jump") and $BikeBody/JumpCheck.get_collider() != null and driving == true:
		$BikeBody.apply_central_impulse(Vector2(0,-1000))
	if $GnomeBody/BonkCheck.get_collider() != null and levelcomplete == false and driving == true:
		driving = false
		var hurtnoise = rng.randi_range(5,8)
		var thudnoise = rng.randi_range(14,15)
		$GnomeBody/CanvasLayer/Control/YouLose.show()
		$GnomeBody/CollisionShape2D.disabled = true
		hidebody()
		spawnragdoll()
		$SoundFXPlayer.stream = Sounds[hurtnoise]
		$SoundFXPlayer.play()
		$ThudNoise.stream = Sounds[thudnoise]
		$ThudNoise.play()
	if Input.is_action_pressed("MoveRight") and grounded == true and driving == true:
		BikeBody.apply_force($LeftWheelPos.position, Vector2(0, 0))
		BikeBody.apply_force($RightWheelPos.position, Vector2(0, -2000))
	if Input.is_action_pressed("MoveLeft") and grounded == true and driving == true:
		BikeBody.apply_force($LeftWheelPos.position, Vector2(0, -1000))
		BikeBody.apply_force($RightWheelPos.position, Vector2(0, 0))
	if Input.is_action_pressed("MoveRight") and grounded == false and driving == true:
		BikeBody.apply_force($LeftWheelPos.position, Vector2(0, 0))
		BikeBody.apply_force($RightWheelPos.position, Vector2(0, -100))
	if Input.is_action_pressed("MoveLeft") and grounded == false and driving == true:
		BikeBody.apply_force($LeftWheelPos.position, Vector2(0, -50))
		BikeBody.apply_force($RightWheelPos.position, Vector2(0, 0))
	if Input.is_action_just_pressed("Restart"):
		restartlevel()
	if Input.is_action_just_pressed("Pause"):
		if paused == false:
			get_tree().paused = true
			paused = true
			$GnomeBody/CanvasLayer/Control/Paused.show()
			$GnomeBody/CanvasLayer/Control/Paused/VBoxContainer/UnpauseButton.grab_focus()
	if Input.is_action_just_pressed("CoinCheck"):
		GlobalVariables.Coincheck()
func PitFall():
	restartlevel()

func IdentifyLevel(LevelName):
	LevelImOn = LevelName
func goaltouched():
	levelcomplete = true
	$GnomeBody/CanvasLayer/Control/YouDidIt.show()
	$GnomeBody/CanvasLayer/Control/YouDidIt/VBoxContainer/MapScreenButton.grab_focus()

func _on_gnome_body_pitfall_fell():
	PitFall()

func StopTimer():
	$GnomeBody/CanvasLayer/Control/TimerLabel.stoptimer(levelcomplete)
	if levelcomplete == true:
		print_debug("Time saved!")

func _on_gnome_body_stop_timer_signal():
	StopTimer()

func _on_timer_label_finishtime(finishedtime):
	levelfinished(LevelImOn,finishedtime)
	
func levelfinished(Level,finishedtime):
	var minutes = (finishedtime / 600)
	var seconds = (finishedtime / 10) % 60
	var milliseconds = finishedtime % 10
	
	if GlobalVariables.LevelTimes.has(LevelImOn):
		if finishedtime < GlobalVariables.LevelTimes[LevelImOn]:
			GlobalVariables.LevelTimes[LevelImOn] = finishedtime
			BestTime = GlobalVariables.LevelTimes[Level]
			GlobalVariables.save_scores()
			$GnomeBody/CanvasLayer/Control/BestTimeIcon.show()
			var besttimenoise = rng.randi_range(9,13)
			$SoundFXPlayer.stream = Sounds[besttimenoise]
			$SoundFXPlayer.play()
		else:
			BestTime = GlobalVariables.LevelTimes[Level]
			var completenoise = rng.randi_range(1,4)
			$SoundFXPlayer.stream = Sounds[completenoise]
			$SoundFXPlayer.play()
	else:
		GlobalVariables.LevelTimes[LevelImOn] = finishedtime
		BestTime = GlobalVariables.LevelTimes[Level]
		print_debug(GlobalVariables.LevelTimes)
		GlobalVariables.save_scores()
		$GnomeBody/CanvasLayer/Control/BestTimeIcon.show()
		playcustscene()

func _on_gnome_body_ihatesignals(LevelName):
	IdentifyLevel(LevelName)


func _on_gnome_body_beat_level():
	goaltouched()

func hidebody():
	for parts in bodyparts:
		parts.hide()
	$GnomeBody/CollisionShape2D.disabled

func _on_map_screen_button_pressed():
	get_tree().change_scene_to_file("res://MapScreen.tscn")
	
func restartlevel():
	get_tree().reload_current_scene()


func _on_try_again_button_pressed():
	restartlevel()


func _on_unpause_button_pressed():
	get_tree().paused = false
	paused = false
	$GnomeBody/CanvasLayer/Control/Paused.hide()


func _on_quit_game_pressed():
	get_tree().quit()


func _on_back_to_map_screen_pressed():
	get_tree().change_scene_to_file("res://MapScreen.tscn")
	get_tree().paused = false
	paused = false

func spawnragdoll():
	$GnomeBody/GnomeRagdoll.show()
	$GnomeBody/GnomeRagdoll.ragdollstart()

func coincollected():
	$SoundFXPlayer.stream = Sounds[0]
	$SoundFXPlayer.play()


func _on_gnome_body_coin_grab():
	coincollected()


func _on_bgm_player_finished():
	$BGMPlayer.play()

func playcustscene():
	match LevelImOn:
		
		"Level 1": GlobalVariables.AdvanceLevel()
		"Level 2": GlobalVariables.AdvanceLevel()
		"Level 3": GlobalVariables.AdvanceLevel()
		"Level 4": GlobalVariables.AdvanceLevel()
		"Level 5": GlobalVariables.AdvanceLevel()
		"Level 6": get_tree().change_scene_to_file("res://Credits.tscn")
