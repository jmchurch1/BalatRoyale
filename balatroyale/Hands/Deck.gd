class_name Deck

var cards :Array[Card]

func _init(full_deck=true) -> void:
	if (full_deck):
		populateFullDeck()
		shuffleDeck()

func populateFullDeck() -> void:
	for i in range(0, 3):
		for j in range(Enums.CardValues.TWO, Enums.CardValues.TEN):
			addCard(Card.new(j, i, Enums.CardAttributes.BASE, Enums.CardTypes.BASE, Enums.CardEditions.BASE, Enums.CardSeals.BASE))
		addCard(Card.new(Enums.CardValues.ELEVEN, i, Enums.CardAttributes.BASE, Enums.CardTypes.ACE, Enums.CardEditions.BASE, Enums.CardSeals.BASE))
		addCard(Card.new(Enums.CardValues.TEN, i, Enums.CardAttributes.BASE, Enums.CardTypes.FACE, Enums.CardEditions.BASE, Enums.CardSeals.BASE, Enums.FaceCards.JACK))
		addCard(Card.new(Enums.CardValues.TEN, i, Enums.CardAttributes.BASE, Enums.CardTypes.FACE, Enums.CardEditions.BASE, Enums.CardSeals.BASE, Enums.FaceCards.QUEEN))
		addCard(Card.new(Enums.CardValues.TEN, i, Enums.CardAttributes.BASE, Enums.CardTypes.FACE, Enums.CardEditions.BASE, Enums.CardSeals.BASE, Enums.FaceCards.KING))

func addCard(card :Card) -> void:
	cards.append(card)

func getFirstCard() -> Card:
	var temporaryDeck = cards.duplicate()
	cards.remove_at(0)
	return temporaryDeck[0]

func shuffleDeck() -> void:
	var temporaryDeck = cards.duplicate()
	for i in range(cards.size()):
		var randomIndex = randi_range(0, temporaryDeck.size() - 1)
		cards[i] = temporaryDeck[randomIndex]
		temporaryDeck.remove_at(randomIndex)

func is_empty() -> bool:
	return cards.is_empty()
	
func _to_string() -> String:
	var return_string = "--- CURRENT DECK ---"
	for card in cards:
		return_string+="\n"+card.to_string()
	return return_string
