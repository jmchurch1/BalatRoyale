class_name Player
extends Node

var jokers = []
var cards = []
var maxCards = 5
var minCards = 0
var maxJokers = 5
var minJokers = 0
# _init(newValue, newSuit, newAttribute, newType, newEdition, newSeal)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cards = [
		Card.new(cardValues.values.SIX, suits.DIAMONDS, attributes.BONUS, cardTypes.BASE, cardEditions.HOLOGRAPHIC, seals.RED),
		Card.new(cardValues.FIVE, suits.DIAMONDS, attributes.BONUS, cardTypes.BASE, cardEditions.BASE, seals.RED),
		Card.new(cardValues.TEN, suits.DIAMONDS, attributes.BONUS, cardTypes.BASE, cardEditions.BASE, seals.RED),
		Card.new(cardValues.TEN, suits.SPADES, attributes.BONUS, cardTypes.BASE, cardEditions.FOIL, seals.RED),
		Card.new(cardValues.FOUR, suits.DIAMONDS, attributes.BONUS, cardTypes.BASE, cardEditions.HOLOGRAPHIC, seals.RED)
	]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func score() -> int:
	return 0

func addJoker(joker: Joker) -> void:
	jokers+=joker
	pass

func addCard(card: Card) -> void:
	cards+=card
	pass

func addRandomCard() -> void:
	var cards = Array(cardValues)
	var suits = suits
	var attributes = attributes
	var cardTypes = cardTypes
	var cardEditions = cardEditions
	var seals = seals
	
	cards+=Card.new(
	)
