class_name GameHand
extends Node

@export var spreadAmount :float
@export var rotateAmount :float
@export var cardScale :float

var cardSprites :Array[Node2D]

func populateHand(hand :Hand) -> void:
	for card in hand.cards:
		addCardSprite(card)

func addCardSprite(card :Card) -> void:
	#calculate path to card texture
	var value = ""
	match card.type:
		Enums.CardTypes.BASE:
			value = String.num_uint64(card.value)
		Enums.CardTypes.ACE:
			value = "ACE"
		Enums.CardTypes.FACE:
			value = Enums.FaceCards.find_key(card.faceCard)
	
	var cardSprite = Sprite2D.new()
	cardSprite.texture = load("res://Art/temporary_cards/%s_%s.png" % \
			[value, Enums.CardSuits.find_key(card.suit)])
	var x = cardSprites.size() * spreadAmount
	if (cardSprites.size() % 2 == 0):
		x *= -1
	
	cardSprite.position = Vector2(x, 0)
	cardSprite.rotate(randf_range(-rotateAmount, rotateAmount))
	cardSprite.scale = Vector2(cardScale, cardScale)
	cardSprite.set_script("res://Cards/Card")
	cardSprites.append(cardSprite)
	add_child(cardSprite)
	pass
