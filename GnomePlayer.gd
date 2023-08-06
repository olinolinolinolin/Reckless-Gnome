extends CharacterBody2D
var speed = 0
var jump = 300
var gravity = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.x += speed * delta
	velocity.y += gravity
	if is_on_floor() == false:
		velocity.y += gravity
	move_and_slide()
	if Input.is_action_just_pressed("Jump") and is_on_floor() == true:
		velocity.y -= jump
	if velocity.x > 0:
		$AnimationPlayer.play("GnomeRiding")
	if Input.is_action_pressed("MoveRight"):
		pass
	if Input.is_action_pressed("MoveLeft"):
		pass


func PitFall():
	get_tree().change_scene_to_file("res://TestingArea.tscn")

func _on_center_check_timeout():
	pass


func _on_bonk_check_body_entered(body):
	print_debug("game over")
