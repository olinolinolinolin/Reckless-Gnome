extends CharacterBody2D
var speed = 20
@onready var GnomeBody = $"../GnomeBody"
@onready var BikeBody = $"../BikeBody"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y += 0 * delta
	velocity.x += speed * delta
	BikeBody.position = $".".position
	GnomeBody.position = $".".position
	move_and_slide()
	if Input.is_action_just_pressed("Jump"):
		$"../GnomeBody/PinJoint2D".queue_free()
