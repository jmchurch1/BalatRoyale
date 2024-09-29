class_name Hand

var parentObject :Node 
var cards :Array[Card]
var highCardValue = -9223372036854775808
var highCard :Card
var lowCardValue = 9223372036854775807
var lowCard :Card

func _init(newCards=[]) -> void:
	for card in newCards:
		addCard(card)

func addCards(cards :Array[Card]) -> void:
	for card in cards:
		addCard(card)


func removeCard(card: Card) -> void:
	cards.remove_at(cards.find(card))

func addCard(card :Card) -> void:
	cards.append(card)
	if card.value > highCardValue:
		highCard = card
	if card.value < lowCardValue:
		lowCard = card

func _to_string() -> String:
	var return_string = "--- CURRENT HAND ---"
	for card in cards:
		return_string+="\n"+card.to_string()
	return return_string
