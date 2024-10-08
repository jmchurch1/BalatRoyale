class_name Card
extends TextureButton

var gameHand: Hand
var player: Player
var played: bool
var dead: bool
var redSealTriggered: bool
var seal: Enums.CardSeals
var edition: Enums.CardEditions
var type: Enums.CardTypes
var attribute: Enums.CardAttributes
var value: Enums.CardValues
var suit: Enums.CardSuits
var faceCard: Enums.FaceCards
var order: Enums.CardOrder
var button: TextureButton

"""
@param newValue :Enums.CardValues
@param newSuit :Enums.CardSuits
@param newAttribute :Enums.CardAttribute
@param newType :Enums.CardTypes
@param newEdition :Enums.CardEditions
@param newSeal :Enums.CardSeals
"""
func _init(newValue, newSuit, newAttribute, newType, newEdition, newSeal, newFaceCard=Enums.FaceCards.UNINITIALIZED):
	if (newType == Enums.CardTypes.FACE && newFaceCard == Enums.FaceCards.UNINITIALIZED):
		push_error("Tried to make a face card with an uninitialized newFaceCard value")
	
	value = newValue
	suit = newSuit
	attribute = newAttribute
	type = newType
	edition = newEdition
	seal = newSeal
	faceCard = newFaceCard
	
	played = false
	dead = false
	redSealTriggered = false
	if newType == Enums.CardTypes.BASE:
		order = Enums.CardOrder.values()[newValue]
	elif newType == Enums.CardTypes.ACE:
		order = Enums.CardOrder.ACE
	else:
		match newFaceCard:
			Enums.FaceCards.JACK:
				order = Enums.CardOrder.JACK
			Enums.FaceCards.QUEEN:
				order = Enums.CardOrder.QUEEN
			Enums.FaceCards.KING:
				order = Enums.CardOrder.KING

"""
score

@return CardScore
"""
func score(score: CardScore) -> CardScore:
	score.value += value
	
	match attribute:
		Enums.CardAttributes.BONUS:
			print("BONUS")
			score.value += 30
		Enums.CardAttributes.MULT:
			print("MULT")
			score.addMult(Enums.MultType.ADD, 4)
		Enums.CardAttributes.GLASS:
			print("GLASS")
			score.addMult(Enums.MultType.MULTIPLY, 2)
			var randDeath = randi_range(1, 4)
			if randDeath == 1:
				print("card died :SOB:")
				dead = true
		Enums.CardAttributes.STEEL:
			print("STEEL")
			if !played:
				score.addMult(Enums.MultType.MULTIPLY, 1.5)
		Enums.CardAttributes.STONE:
			print("STONE")
			score.value += 50
		Enums.CardAttributes.GOLD:
			print("GOLD")
			score.money += 3
		Enums.CardAttributes.LUCKY:
			print("LUCKY")
			var randMult = randi_range(1,5)
			var randMoney = randi_range(1,15)
			if randMult == 1:
				score.addMult(Enums.MultType.ADD, 20)
			if randMoney == 1:
				score.money += 20
	
	match edition:
		Enums.CardEditions.BASE:
			print("BASE")
		Enums.CardEditions.FOIL:
			print("FOIL")
			score.value += 50 
		Enums.CardEditions.HOLOGRAPHIC:
			print("HOLOGRAPHIC")
			score.addMult(Enums.MultType.ADD, 10)
		Enums.CardEditions.POLYCHROME:
			print("POLYCHROME")
			score.addMult(Enums.MultType.MULTIPLY, 1.5)
	
	match seal:
		Enums.CardSeals.BASE:
			print("BASE")
		Enums.CardSeals.GOLD:
			print("GOLD")
			score.money += 3
		Enums.CardSeals.RED:
			print("RED")
			if !redSealTriggered:
				redSealTriggered = true
				score = score(score)
		Enums.CardSeals.BLUE:
			print("BLUE")
			## MAKE A PLANET CARD
		Enums.CardSeals.PURPLE:
			print("PURPLE")
			## MAKE A TAROT CARD
	return score

var MouseOver = false

func makeButtonFunctionality():
	var name = ""
	match self.type:
		Enums.CardTypes.BASE:
			name = String.num_uint64(value)
		Enums.CardTypes.ACE:
			name = "ACE"
		Enums.CardTypes.FACE:
			name = Enums.FaceCards.find_key(faceCard)
	
	pressed.connect(self._button_pressed)
	var path = "res://Art/temporary_cards/%s_%s.png" % \
			[name, Enums.CardSuits.find_key(suit)]
	texture_normal = load(path)
	texture_pressed = load(path)
	texture_hover = load(path)
	texture_disabled = load(path)

func _button_pressed():
	if (player.hand.cards.size() < player.maxCards && !played):
		played = true
		var card = cardReference()
		player.addCard(card)
		gameHand.deactivateGameHandCard(self)
	elif (played):
		player.removeCard(cardReference())
		gameHand.activateGameHandCard(self)
		played = false

func resetCard() -> void:
	redSealTriggered = false
	played = false

func cardReference() -> Card:
	return Card.new(self.value, self.suit, self.attribute, \
			self.type, self.edition, self.seal, self.faceCard)  

func _equals(other :Card) -> bool:
	return self.value == other.value && self.suit == other.suit && \
		self.attribute == other.attribute && self.type == other.type && \
		self.edition == other.edition && self.seal == other.seal && \
		self.faceCard == other.faceCard

func _to_string() -> String:
	var return_string = "Value: %s Suit: %s Attribute: %s Type: %s Edition: %s Seal: %s Face Card: %s"
	return return_string % [Enums.CardValues.find_key(value).rpad(13), \
	 						Enums.CardSuits.find_key(suit).rpad(13), \
							Enums.CardAttributes.find_key(attribute).rpad(13), \
							Enums.CardTypes.find_key(type).rpad(13), \
							Enums.CardEditions.find_key(edition).rpad(13), \
							Enums.CardSeals.find_key(seal).rpad(13), \
							Enums.FaceCards.find_key(faceCard)]
