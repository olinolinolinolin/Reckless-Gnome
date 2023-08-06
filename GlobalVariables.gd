extends Node
var FurthestLevel = 1
var CoinCounter = 0
var LevelCompleteTime = 0.0
var controlleruseing = false
var save_path = "user://scores.save"
var LevelTimes = {
	
}
var CoinsCollected = [false,false,false,false,false,false]
var hassave = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func load_scores():
	if FileAccess.file_exists(save_path):
		print("file found")
		var file = FileAccess.open(save_path, FileAccess.READ)
		LevelTimes = file.get_var()
		FurthestLevel = file.get_var()
		CoinsCollected = file.get_var()
		hassave = true
	else:
			print("file not found")
			FurthestLevel = 1
			LevelTimes = {}
			CoinsCollected = [false,false,false,false,false,false]

func save_scores():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(LevelTimes)
	file.store_var(FurthestLevel)
	file.store_var(CoinsCollected)

func Coincheck():
	for Coins in CoinsCollected:
		if CoinsCollected[CoinCounter] == true:
			CoinCounter += 1
	if CoinCounter == 5:
		print_debug("All Coins Collected")

func NewSave():
	FurthestLevel = 1
	LevelTimes = {}
	CoinsCollected = [false,false,false,false,false,false]
	save_scores()
	
func AdvanceLevel():
	FurthestLevel += 1
	save_scores()
