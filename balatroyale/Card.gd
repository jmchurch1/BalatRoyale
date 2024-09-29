class_name Card
extends Node

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

"""
@param newValue :Enums.CardValues
@param newSuit :Enums.CardSuits
@param newAttribute :Enums.CardAttribute
@param newType :Enums.CardTypes
@param newEdition :Enums.CardEditions
@param newSeal :Enums.CardSeals
"""
func _init(newValue, newSuit, newAttribute, newType, newEdition, newSeal, newFaceCard=Enums.FaceCards.UNINITIALIZED):
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

func resetCard() -> void:
	redSealTriggered = false
	played = false

func _to_string() -> String:
	var return_string = "Value: %s Suit: %s Attribute: %s Type: %s Edition: %s Seal: %s"
	return return_string % [Enums.CardValues.find_key(value).rpad(13), \
	 						Enums.CardSuits.find_key(suit).rpad(13), \
							Enums.CardAttributes.find_key(attribute).rpad(13), \
							Enums.CardTypes.find_key(type).rpad(13), \
							Enums.CardEditions.find_key(edition).rpad(13), \
							Enums.CardSeals.find_key(seal).rpad(13)]
