class_name Hand
extends Node

@export var spreadAmount = 25.0
@export var rotateAmount = 0.07
@export var cardScale = 0.2

var player :Player
var parentObject :Node 
var cards :Array[Card]
var highCardValue = -9223372036854775808
var highCard :Card
var lowCardValue = 9223372036854775807
var lowCard :Card

func _init(newCards=[]) -> void:
	for card in newCards:
		addCard(card)

func addCards(newCards :Array[Card]) -> void:
	for card in newCards:
		addCard(card)

#NOTE: need to do some sprite removal here
func removeCard(card: Card) -> void:
	var index = cards.find(card)
	cards[index].queue_free()
	cards.remove_at(index)
	

func addCard(card :Card) -> void:
	if card.value > highCardValue:
		highCard = card
	if card.value < lowCardValue:
		lowCard = card
	
	var x = cards.size() * spreadAmount
	
	card.position = Vector2(x, 0)
	card.rotation += randf_range(-rotateAmount, rotateAmount)
	card.scale = Vector2(cardScale, cardScale)
	
	if (card.button == null):
		card.makeButtonFunctionality()
	
	cards.append(card)
	card.player = player
	card.gameHand = self
	add_child(card)
	
	placeCards()

func placeCards() -> void:
	var startingPos = -cards.size() * (cards[0].size[1]/40 + spreadAmount)/2
	var iteration = 0
	for card in cards:
		card.position = Vector2(startingPos + iteration * (cards[0].size[1]/40 + spreadAmount), 0)
		iteration += 1

func deactivateGameHandCard(card :Card) -> void:
	card.position += Vector2(0, -20)
	card.self_modulate = Color.AQUA

func activateGameHandCard(card :Card) -> void:
	card.position -= Vector2(0, -20)
	card.self_modulate = Color.WHITE

func contains(other :Card) -> Card:
	for card in cards:
		if (card._equals(other)):
			return card
	return null

func _to_string() -> String:
	var return_string = "--- CURRENT HAND ---"
	for card in cards:
		return_string+="\n"+card.to_string()
	return return_string
