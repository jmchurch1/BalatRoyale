class_name Main
extends Node

@export var gameHandSize :int
@onready var gameHand = get_node("CanvasLayer/GameHand") as GameHand

var playerType = Enums.Parents.GAME
var deck :Deck
var discardDeck :Deck
var currentHand :Hand
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentHand = Hand.new()
	deck = Deck.new()
	discardDeck = Deck.new(false)
	makeHand()
	
	#fake hand for player
	var cardArray :Array[Card]
	var playerOne = Player.new(cardArray, Enums.Parents.PLAYER_ONE)

func makeHand() -> void:
	for i in range(gameHandSize):
		if (deck.is_empty() && discardDeck.is_empty()):
			return
		elif (deck.is_empty()):
			shuffleInDiscard()
		var newCard = deck.getFirstCard()
		currentHand.addCard(newCard)
	gameHand.populateHand(currentHand)

#func activateGameHandCard(card :Card) -> Card:
	#
	#pass

func shuffleInDiscard() -> void:
	discardDeck.shuffleDeck()
	for i in range(discardDeck.cards.size()):
		deck.addCard(discardDeck.getFirstCard())
