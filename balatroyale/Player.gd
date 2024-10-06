class_name Player
extends Node

@export var hand :Hand
var main :Main
var chipsLabel :RichTextLabel
var multLabel :RichTextLabel
var handLabel :RichTextLabel
var overallScoreLabel :RichTextLabel
var handsRemainingLabel :RichTextLabel
var discardsRemainingLabel :RichTextLabel
var jokers :Array[Joker]
var handManager :Hands
var maxCards = 5
var minCards = 0
var maxJokers = 5
var minJokers = 0
var maxHandsRemaining = 5
var currentHandsRemaining = 5
var money = 0
var mult = 1.0
var chips = 0

func _init() -> void:
	handManager = Hands.new()

func addMainReference(main :Main) -> void:
	self.main = main

func addLabels(chipsLabel :RichTextLabel, multLabel :RichTextLabel, 
	handLabel :RichTextLabel, overallScoreLabel: RichTextLabel, handsRemainingLabel :RichTextLabel) -> void:
	self.chipsLabel = chipsLabel
	self.multLabel = multLabel
	self.handLabel = handLabel
	self.overallScoreLabel = overallScoreLabel
	self.handsRemainingLabel = handsRemainingLabel

func scoreHand():
	var handScore = handManager.findBestHand(hand)
	chips += handScore[0]
	mult += handScore[1]
	for card in hand.cards:
		card.played = true
		card.self_modulate = Color.YELLOW
		var cardScore = card.score(CardScore.new(money, chips, mult))
		print(cardScore.to_string())
		addScore(cardScore)
		await get_tree().create_timer(0.5).timeout
	currentHandsRemaining -= 1
	handsRemainingLabel.clear()
	handsRemainingLabel.add_text(String.num_int64(currentHandsRemaining))
	if (currentHandsRemaining != 0):
		main.playerDone()
		hand.removeAllCards()

func addScore(cardScore :CardScore) -> void:
	money = cardScore.money
	chips = cardScore.value
	mult = cardScore.mult
	chipsLabel.clear()
	multLabel.clear()
	overallScoreLabel.clear()
	chipsLabel.add_text(String.num_int64(cardScore.value))
	multLabel.add_text(String.num(mult))
	overallScoreLabel.add_text(String.num_scientific(chips * mult))
	var return_string = "%s X %s \n Money: %s"
	print(return_string % [String.num_int64(chips), String.num(mult), String.num_int64(money)])

func addJoker(joker: Joker) -> void:
	print(joker.to_string())
	jokers.append(joker)
	pass

func addCard(card: Card) -> void:
	hand.addCard(card)
	handManager.findBestHand(hand)
	var bestHand = handManager.bestHand
	handLabel.clear()
	var handText = "%s lvl.%s" % \
		[Enums.HandTypes.find_key(bestHand), \
		String.num_int64(handManager.handLevels.get(bestHand))]
	handLabel.add_text(handText)
	
	if (hand.cards.size() == maxCards):
		scoreHand()

func removeCard(card: Card) -> void:
	var playerCard = hand.contains(card)
	if null != playerCard:
		hand.removeCard(playerCard)

func addCards(cards :Array[Card]) -> void:
	for card in cards:
		addCard(card)

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
