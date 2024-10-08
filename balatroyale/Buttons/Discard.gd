class_name DiscardButton
extends Button
@export var player :Player

func _ready() -> void:
	self.pressed.connect(self._button_pressed)
	
func _button_pressed() -> void:
	if (null == player.hand):
		return
	
	await player.hand.removeAllCards()
	await player.main.playerDone()
