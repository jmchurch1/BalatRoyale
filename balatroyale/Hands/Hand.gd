class_name Hand

var cards :Array[Card]
var highCard = -9223372036854775808
var lowCard = 9223372036854775807

func _init(newCards=[]) -> void:
	for card in newCards:
		addCard(card)

func addCard(card :Card) -> void:
	cards.append(card)
	if card.value > highCard:
		highCard = card.value
	if card.value < lowCard:
		lowCard = card.value

func removeCard(card: Card) -> void:
	cards.remove_at(cards.find(card))

func _to_string() -> String:
	var return_string = "--- CURRENT HAND ---"
	for card in cards:
		return_string+="\n"+card.to_string()
	return return_string
