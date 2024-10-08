class_name PlayButton
extends Button
@export var player :Player

func _ready() -> void:
	self.pressed.connect(self._button_pressed)
	
func _button_pressed() -> void:
	if (null == player.hand):
		return
	await player.scoreHand()
	await player.hand.removeAllCards()
	await player.main.playerDone()
