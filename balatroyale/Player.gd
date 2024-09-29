class_name Player
extends Node

var jokers :Array[Joker]
var handManager :Hands
var hand :Hand
var maxCards = 5
var minCards = 0
var maxJokers = 5
var minJokers = 0
var money = 0
var mult = 1.0
var chips = 0

func _init(cards :Array[Card]) -> void:
	hand = Hand.new()
	handManager = Hands.new()
	print("Adding cards from hand")
	for card in cards:
		addCard(card)
	scoreHand()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func scoreHand():
	var handScore = handManager.findBestHand(hand)
	chips += handScore[0]
	mult += handScore[1]
	for card in hand.cards:
		card.played = true
		var cardScore = card.score(CardScore.new(money, chips, mult))
		print(cardScore.to_string())
		addScore(cardScore)

func addScore(cardScore :CardScore) -> void:
	money = cardScore.money
	chips = cardScore.value
	mult = cardScore.mult
	var return_string = "%s X %s \n Money: %s"
	print(return_string % [String.num_int64(chips), String.num(mult), String.num_int64(money)])

func addJoker(joker: Joker) -> void:
	print(joker.to_string())
	jokers.append(joker)
	pass

func addCard(card: Card) -> void:
	hand.addCard(card)
	print(card.to_string())

func addRandomCard() -> void:
	var CardValuesArray = Enums.CardValues.keys()
	var SuitsArray = Enums.CardSuits.keys()
	var CardAttributesArray = Enums.CardAttributes.keys()
	var TypeArray = Enums.CardTypes.keys()
	var CardEditionsArray = Enums.CardEditions.keys()
	var SealsArray = Enums.CardSeals.keys()

	var newValue = randi_range(0, CardValuesArray.size() - 1)
	var newSuit = randi_range(0, SuitsArray.size() - 1)
	var newAttribute = randi_range(0, CardAttributesArray.size() - 1)
	var newType = randi_range(0, TypeArray.size() - 1)
	var newEdition = randi_range(0, CardEditionsArray.size() - 1)
	var newSeal = randi_range(0, SealsArray.size() - 1)
	
	var newCard = Card.new(newValue, newSuit, newAttribute, newType, newEdition, newSeal)
	addCard(newCard)
