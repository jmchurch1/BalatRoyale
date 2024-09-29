extends Node

var gameHandSize = 25
var deck :Deck
var discardDeck :Deck
var currentHand :Hand
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentHand = Hand.new()
	deck = Deck.new()
	print(deck.to_string())
	discardDeck = Deck.new(false)
	makeHand()
	print(deck.to_string())
	print(currentHand.to_string())
	
	var cardArray :Array[Card]
	cardArray.append(currentHand.cards[0])
	cardArray.append(currentHand.cards[1])
	cardArray.append(currentHand.cards[2])
	cardArray.append(currentHand.cards[3])
	cardArray.append(currentHand.cards[4])
	var playerOne = Player.new(cardArray)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func makeHand() -> void:
	for i in range(gameHandSize):
		if (deck.is_empty() && discardDeck.is_empty()):
			return
		elif (deck.is_empty()):
			shuffleInDiscard()
		var newCard = deck.getFirstCard()
		currentHand.addCard(newCard)

func shuffleInDiscard() -> void:
	discardDeck.shuffleDeck()
	for i in range(discardDeck.cards.size()):
		deck.addCard(discardDeck.getFirstCard())
