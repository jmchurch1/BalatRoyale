class_name Card
extends Node

var played: bool
var seal: seals
var edition: cardEditions
var type: cardTypes
var attribute: attributes
var value: cardValues
var suit: suits
var dead = false

func _init(newValue, newSuit, newAttribute, newType, newEdition, newSeal):
	value = newValue
	suit = newSuit
	attribute = newAttribute
	type = newType
	edition = newEdition
	seal = newSeal

"""
score

@return CardScore
"""
func score(score: CardScore) -> CardScore:
	score.value += value
	
	match attribute:
		attributes.BASE:
			print("BASE")
		attributes.BONUS:
			print("BONUS")
			score.value += 30
		attributes.MULT:
			print("MULT")
			score.addMult(MultType.ADDITION, 4)
		attributes.GLASS:
			print("GLASS")
			score.addMult(MultType.MULTIPLY, 2)
			var randDeath = randi_range(1, 4)
			if randDeath == 1:
				dead = true
		attributes.STEEL:
			print("STEEL")
			if !played:
				score.addMult(MultType.MULTIPLY, 1.5)
		attributes.STONE:
			print("STONE")
			score.value += 50
		attributes.GOLD:
			print("GOLD")
			score.money += 3
		attributes.LUCKY:
			print("LUCKY")
			var randMult = randi_range(1,5)
			var randMoney = randi_range(1,15)
			if randMult == 1:
				score.addMult(MultType.ADDITION, 20)
			if randMoney == 1:
				score.money += 20
	
	match edition:
		cardEditions.BASE:
			print("BASE")
		cardEditions.FOIL:
			print("FOIL")
			score.value += 50 
		cardEditions.HOLOGRAPHIC:
			print("HOLOGRAPHIC")
			score.addMult(MultType.ADDITION, 10)
		cardEditions.POLYCHROME:
			print("POLYCHROME")
			score.addMult(MultType.MULTIPLY, 1.5)
	
	match seal:
		seals.BASE:
			print("BASE")
		seals.GOLD:
			print("GOLD")
			score.money += 3
		seals.RED:
			print("RED")
			score = score(score)
		seals.BLUE:
			print("BLUE")
			## MAKE A PLANET CARD
		seals.PURPLE:
			print("PURPLE")
			## MAKE A TAROT CARD
	
	return score
