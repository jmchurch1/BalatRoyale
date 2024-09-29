class_name Deck

var cards :Array[Card]

func _init(full_deck=true) -> void:
	if (full_deck):
		populateFullDeck()
	print("--- FULLY POPULATED BASE DECK ---")
	for card in cards:
		print(card.to_string())
	pass

func populateFullDeck() -> void:
	for i in range(0, 3):
		for j in range(1, 10):
			addCard(Card.new(j, i, Enums.CardAttributes.BASE, Enums.CardTypes.BASE, Enums.CardEditions.BASE, Enums.CardSeals.BASE))
		addCard(Card.new(Enums.CardValues.ELEVEN, i, Enums.CardAttributes.BASE, Enums.CardTypes.ACE, Enums.CardEditions.BASE, Enums.CardSeals.BASE))
		addCard(Card.new(Enums.CardValues.TEN, i, Enums.CardAttributes.BASE, Enums.CardTypes.FACE, Enums.CardEditions.BASE, Enums.CardSeals.BASE, Enums.FaceCards.JACK))
		addCard(Card.new(Enums.CardValues.TEN, i, Enums.CardAttributes.BASE, Enums.CardTypes.FACE, Enums.CardEditions.BASE, Enums.CardSeals.BASE, Enums.FaceCards.QUEEN))
		addCard(Card.new(Enums.CardValues.TEN, i, Enums.CardAttributes.BASE, Enums.CardTypes.FACE, Enums.CardEditions.BASE, Enums.CardSeals.BASE, Enums.FaceCards.KING))

func addCard(card :Card) -> void:
	cards.append(card)

func shuffleDeck() -> void:
	pass
