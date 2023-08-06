extends Area2D
enum CoinNumber {Coin1, Coin2, Coin3, Coin4, Coin5, Coin6}
@export var CoinToUse = CoinNumber.Coin1

# Called when the node enters the scene tree for the first time.
func _ready():
	match CoinToUse:
		CoinNumber.Coin1: if GlobalVariables.CoinsCollected[0] == true:
			queue_free()
		CoinNumber.Coin2: if GlobalVariables.CoinsCollected[1] == true:
			queue_free()
		CoinNumber.Coin3: if GlobalVariables.CoinsCollected[2] == true:
			queue_free()
		CoinNumber.Coin4: if GlobalVariables.CoinsCollected[3] == true:
			queue_free()
		CoinNumber.Coin5: if GlobalVariables.CoinsCollected[4] == true:
			queue_free()
		CoinNumber.Coin6: if GlobalVariables.CoinsCollected[5] == true:
			queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.coincollected()
		match CoinToUse:
			CoinNumber.Coin1: GlobalVariables.CoinsCollected[0] = true
			CoinNumber.Coin2: GlobalVariables.CoinsCollected[1] = true
			CoinNumber.Coin3: GlobalVariables.CoinsCollected[2] = true
			CoinNumber.Coin4: GlobalVariables.CoinsCollected[3] = true
			CoinNumber.Coin5: GlobalVariables.CoinsCollected[4] = true
			CoinNumber.Coin6: GlobalVariables.CoinsCollected[5] = true
		queue_free()
