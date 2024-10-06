class_name Main
extends Node

@export var gameHandSize :int
@export var playerChipsLabel :RichTextLabel
@export var playerMultLabel :RichTextLabel
@export var playerHandLabel :RichTextLabel
@export var playerOverallScoreLabel : RichTextLabel
@export var playerHandsLabel :RichTextLabel

@onready var gameHand = get_node("CanvasLayer/GameHand") as Hand
@onready var multiplayerSpawner = get_node("MultiplayerSpawner") as MultiplayerSpawner
@onready var playerScene = load("res://player.tscn")

var playerType = Enums.Parents.GAME
var deck :Deck
var discardDeck :Deck
var currentHand :Hand
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = playerScene.instantiate()
	player.name = "Player_" + String.num_uint64(1)
	gameHand.player = player
	get_node("/root/Main/SpawnRoot").add_child(player, true)
	player.addLabels(playerChipsLabel, playerMultLabel, playerHandLabel, playerOverallScoreLabel, playerHandsLabel)
	player.addMainReference(self)
	deck = Deck.new()
	discardDeck = Deck.new(false)
	makeHand()

func playerDone() -> void:
	var discardDeckAdditions = await gameHand.removeAndReturnPlayed()
	for card in discardDeckAdditions:
		discardDeck.addCard(card)
	makeHand()

func makeHand() -> void:
	for i in range(gameHandSize - gameHand.cards.size()):
		if (deck.is_empty() && discardDeck.is_empty()):
			return
		elif (deck.is_empty()):
			shuffleInDiscard()
		var newCard = deck.getFirstCard()
		gameHand.addCard(newCard)

func shuffleInDiscard() -> void:
	discardDeck.shuffleDeck()
	for i in range(discardDeck.cards.size()):
		deck.addCard(discardDeck.getFirstCard())
