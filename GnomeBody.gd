extends RigidBody2D
signal  PitfallFell
signal StopTimerSignal
signal Ihatesignals
signal BeatLevel
signal CoinGrab
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func LevelBeat():
	BeatLevel.emit()

func PitFall():
	PitfallFell.emit()

func StopTimer():
	StopTimerSignal.emit()

func IdentifyLevel(LevelName):
	Ihatesignals.emit(LevelName)

func coincollected():
	CoinGrab.emit()
