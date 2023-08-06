extends Node2D
var limbs = []

# Called when the node enters the scene tree for the first time.
func _ready():
	limbs = get_tree().get_nodes_in_group("limb")
	for limb in limbs:
		limb.set_freeze_enabled(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func ragdollstart():
	for limb in limbs:
		limb.set_freeze_enabled(false)
	$HeadRagdoll/CollisionShape2D.disabled = false
	$BodyRagdoll/CollisionShape2D.disabled = false
	$LeftLegRagdoll/CollisionShape2D.disabled = false
	$RightLegRagdoll/CollisionShape2D.disabled = false
	$LeftArmRagdoll/CollisionShape2D.disabled = false
	$RightArmRagdoll/CollisionShape2D.disabled = false
