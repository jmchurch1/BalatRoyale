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
	cards.remove_at(cards.find(card))
	

func addCard(card :Card) -> void:
	if card.value > highCardValue:
		highCard = card
	if card.value < lowCardValue:
		lowCard = card
	
	var x = cards.size() * spreadAmount
	if (cards.size() % 2 == 0):
		x *= -1
	
	card.position = Vector2(x, 0)
	card.rotation += randf_range(-rotateAmount, rotateAmount)
	card.scale = Vector2(cardScale, cardScale)
	
	if (card.button == null):
		card.makeButtonFunctionality()
	
	cards.append(card)
	card.player = player
	card.gameHand = self
	add_child(card)

func deactivateGameHandCard(card :Card) -> void:
	card.position += Vector2(0, -20)
	card.self_modulate = Color.AQUA
	#var iteration = 0
	#for c in cards:
		#var x = iteration * spreadAmount
		#if (cards.size() % 2 == 0):
			#x *= -1
		#
		#c.position = Vector2(x, 0)
		#c.rotation += randf_range(-rotateAmount, rotateAmount)
		#iteration+=1

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
