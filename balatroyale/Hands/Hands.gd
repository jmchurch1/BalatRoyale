class_name Hands

var bestHand = -1
"""
Flush Five	15 mult, 150 chip
Flush House	14 mult, 140 chip
Five of a Kind	12 mult, 120 chip
Royal Flush ???
Straight Flush	10 mult, 100 chip
Four of a Kind	8 mult, 60 chip
Straight	4 mult, 35 chip
Full house	4 mult, 40 chip
Flush	3 mult, 35 chip
Three of a Kind	3 mult, 30 chip
Two Pair	2 mult, 20 chip
Pair	2 mult, 15 chip
High Card	1 mult, 10 chip
"""
var handValues = {
	Enums.HandTypes.FlushFive : [150,15],
	Enums.HandTypes.FlushHouse : [140,14],
	Enums.HandTypes.FiveOfAKind : [120,12],
	Enums.HandTypes.RoyalFlush : [100,10],
	Enums.HandTypes.StraightFlush : [100,10],
	Enums.HandTypes.FourOfAKind : [60,8],
	Enums.HandTypes.FullHouse : [40,4],
	Enums.HandTypes.Flush : [35,3],
	Enums.HandTypes.Straight : [35,4],
	Enums.HandTypes.ThreeOfAKind : [30,3],
	Enums.HandTypes.TwoPair : [20,2],
	Enums.HandTypes.Pair : [15,2],
	Enums.HandTypes.HighCard : [10,1]
} as Dictionary

var handIncrease = {
	Enums.HandTypes.FlushFive : [150,15],
	Enums.HandTypes.FlushHouse : [140,14],
	Enums.HandTypes.FiveOfAKind : [120,12],
	Enums.HandTypes.RoyalFlush : [100,8],
	Enums.HandTypes.StraightFlush : [100,10],
	Enums.HandTypes.FourOfAKind : [60,8],
	Enums.HandTypes.FullHouse : [40,4],
	Enums.HandTypes.Flush : [35,3],
	Enums.HandTypes.Straight : [35,4],
	Enums.HandTypes.ThreeOfAKind : [30,3],
	Enums.HandTypes.TwoPair : [20,2],
	Enums.HandTypes.Pair : [15,2],
	Enums.HandTypes.HighCard : [10,1]
} as Dictionary

var handLevels = {
	Enums.HandTypes.FlushFive : 1,
	Enums.HandTypes.FlushHouse : 1,
	Enums.HandTypes.FiveOfAKind : 1,
	Enums.HandTypes.RoyalFlush : 1,
	Enums.HandTypes.StraightFlush : 1,
	Enums.HandTypes.FourOfAKind : 1,
	Enums.HandTypes.FullHouse : 1,
	Enums.HandTypes.Flush : 1,
	Enums.HandTypes.Straight : 1,
	Enums.HandTypes.ThreeOfAKind : 1,
	Enums.HandTypes.TwoPair : 1,
	Enums.HandTypes.Pair : 1,
	Enums.HandTypes.HighCard : 1
} as Dictionary

func _init() -> void:
	# initailize hands with starting level of 1
	for handType in Enums.HandTypes.keys():
		handLevels.get_or_add(handType, 1)
	pass

func updateHandValue(handType :Enums.HandTypes) -> void:
	var previous = Array(handValues.get(handType))
	var addition = Array(handIncrease.get(handType))
	handValues.get_or_add(handType, [previous[0] + addition[0], previous[1] + addition[1]])
	pass
	
func findBestHand(hand: Hand) -> Array:
	var possibleHands :Array
	if (hand.cards.is_empty()):
		return [0,0]
	if checkFlushFive(hand):
		possibleHands.append(Enums.HandTypes.FlushFive)
	if checkFlushHouse(hand):
		possibleHands.append(Enums.HandTypes.FlushHouse)
	if checkAmountOfAKind(hand, 5):
		possibleHands.append(Enums.HandTypes.FiveOfAKind)
	if checkRoyalFlush(hand):
		possibleHands.append(Enums.HandTypes.RoyalFlush)
	if checkStraightFlush(hand):
		possibleHands.append(Enums.HandTypes.StraightFlush)
	if checkAmountOfAKind(hand, 4):
		possibleHands.append(Enums.HandTypes.FourOfAKind)
	if checkFullHouse(hand):
		possibleHands.append(Enums.HandTypes.FullHouse)
	if checkFlush(hand):
		possibleHands.append(Enums.HandTypes.Flush)
	if checkStraight(hand):
		possibleHands.append(Enums.HandTypes.Straight)
	if checkAmountOfAKind(hand, 3):
		possibleHands.append(Enums.HandTypes.ThreeOfAKind)
	if checkTwoPair(hand):
		possibleHands.append(Enums.HandTypes.TwoPair)
	if checkPair(hand):
		possibleHands.append(Enums.HandTypes.Pair)
	if checkHighCard(hand):
		possibleHands.append(Enums.HandTypes.HighCard)
	
	var highestCombo = [0, 0]
	var tmpBest :int
	for handType in possibleHands:
		var newCombo = handValues.get(handType)
		if newCombo[0] * newCombo[1] > highestCombo[0] * highestCombo[1]:
			highestCombo = newCombo
			tmpBest = handType
	
	self.bestHand = tmpBest
	print("The best hand was %s with a combo of %s X %s" % \
		[Enums.HandTypes.find_key(self.bestHand), \
		String.num_int64(highestCombo[0]), \
		String.num_int64(highestCombo[1])])
	
	return highestCombo

func checkFlushFive(hand :Hand) -> bool:
	return checkSameSuit(hand) && checkAmountOfAKind(hand, 5)

func checkFlushHouse(hand :Hand) -> bool:
	return checkSameSuit(hand) && checkFullHouse(hand)

func checkRoyalFlush(hand :Hand) -> bool:
	if (!checkSameSuit(hand)):
		return false
	var foundCards = [false, false, false, false, false]
	for card in hand.cards:
		if (card.type == Enums.CardTypes.ACE):
			foundCards[0] = true
			if (card.faceCard == Enums.FaceCards.KING):
				foundCards[1] = true
			if (card.faceCard == Enums.FaceCards.QUEEN):
				foundCards[2] = true
			if (card.faceCard == Enums.FaceCards.JACK):
				foundCards[3] = true
			if (card.value == Enums.CardValues.TEN):
				foundCards[3] = true
	return foundCards[0] && foundCards[1] && 	foundCards[2] && \
		   foundCards[3] && foundCards[4]

func checkStraightFlush(hand :Hand) -> bool:
	# check that all the cards are the same suit or wild
	if (!checkSameSuit(hand)):
		return false
	# check the cards are all in order
	var copyCards = hand.cards.duplicate()
	copyCards.remove_at(copyCards.find(hand.lowCard))
	var iterations = 1
	while true:
		if (iterations >= 5):
			return true
		var nextValue = hand.lowCardValue + iterations
		var foundNextValue = false
		for card in copyCards:
			if(card.value == nextValue):
				foundNextValue = true
		if (!foundNextValue):
			return false
		iterations += 1
	return true

func checkFullHouse(hand :Hand) -> bool:
	var removedRank = Enums.CardValues.UNINITIALIZED
	for card1 in range(hand.cards.size() - 1):
		var ofAKind = 0
		var card2 = card1 + 1
		while card2 < hand.cards.size():
			if (hand.cards[card1].value == hand.cards[card2].value):
				ofAKind += 1
				if (ofAKind >= 3):
					removedRank = hand.cards[card1].value
					break
			card2+=1
		if (removedRank != Enums.CardValues.UNINITIALIZED):
			break
	if (removedRank != Enums.CardValues.UNINITIALIZED):
		return checkPair(hand, removedRank)
	return false

func checkFlush(hand :Hand) -> bool:
	return checkSameSuit(hand) && hand.cards.size() >= 5

# check if a hand has a straight in it
func checkStraight(hand :Hand) -> bool:
	# check the cards are all in order
	var copyCards = hand.cards.duplicate()
	copyCards.remove_at(copyCards.find(hand.lowCard))
	var iterations = 1
	while true:
		if (iterations >= 5):
			return true
		var nextValue = hand.lowCardValue + iterations
		var foundNextValue = false
		for card in copyCards:
			if(card.value == nextValue):
				foundNextValue = true
		if (!foundNextValue):
			return false
		iterations += 1
	return true

# check if a hand has a three of a kind in it
func checkAmountOfAKind(hand :Hand, amount: int) -> bool:
	for card1 in range(hand.cards.size() - 1):
		var ofAKind = 0
		var card2 = card1 + 1
		while card2 < hand.cards.size():
			if (hand.cards[card1].value == hand.cards[card2].value):
				ofAKind += 1
				if (ofAKind >= amount):
					return true
			card2+=1
	return false

# check if a hand has two pairs in it
func checkTwoPair(hand :Hand) -> bool:
	var pairs = 0
	for card1 in range(hand.cards.size() - 1):
		var card2 = card1 + 1
		while card2 < hand.cards.size():
			if (hand.cards[card1].value == hand.cards[card2].value):
				pairs+=1
				if (pairs >= 2):
					return true
			card2+=1
	return false

# check if a hand has a pair
func checkPair(hand :Hand, removedValue=Enums.CardValues.UNINITIALIZED) -> bool:
	for card1 in range(hand.cards.size() - 1):
		# helper for Full House
		if (hand.cards[card1].value == removedValue):
			continue
		var card2 = card1 + 1
		while card2 < hand.cards.size():
			if (hand.cards[card1].value == hand.cards[card2].value):
				return true
			card2+=1
	return false
	
# check if a hand has any cards in it
func checkHighCard(hand :Hand) -> bool:
	return !hand.cards.is_empty()

func checkSameSuit(hand :Hand) -> bool:
	# check that all the cards are the same suit or wild
	var nonWildSuit = -1
	for card in hand.cards:
		if (card.suit != Enums.CardSuits.WILD && nonWildSuit == -1):
			nonWildSuit = card.suit
		if (card.suit != Enums.CardSuits.WILD && nonWildSuit != -1 && nonWildSuit != card.suit):
			return false
	return true
