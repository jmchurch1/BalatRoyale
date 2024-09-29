class_name Enums
enum MultType {
	MULTIPLY,
	ADD
}

enum CardSuits {
	CLUBS, 
	HEARTS, 
	DIAMONDS, 
	SPADES, 
	WILD
}

enum CardTypes {
	BASE,
	FACE,
	ACE
}

enum CardValues {
	UNINITIALIZED, 
	ONE, 
	TWO, 
	THREE, 
	FOUR, 
	FIVE, 
	SIX, 
	SEVEN, 
	EIGHT, 
	NINE, 
	TEN,
	ELEVEN
}

enum FaceCards {
	UNINITIALIZED,
	JACK,
	QUEEN,
	KING
}

"""
BASE:
	No extra effects
FOIL:
	+50 Chips
HOLOGRAPHIC:
	+10 Mult
POLYCHROME:
	x1.5 Mult
NEGATIVE:
	+1 Joker slot when on Jokers
"""
enum CardEditions {
	BASE, 
	FOIL, 
	HOLOGRAPHIC, 
	POLYCHROME, 
	NEGATIVE
}

"""
BASE:
	No extra effects
BONUS:
	+30 Chips
MULT:
	+4 Mult
WILD:
	Is considered to be every suit simultaneously
GLASS:
	x2 Mult
	1 in 4 chance to destroy card after all scoring is finished
STEEL:
	x1.5 Mult while this card stays in hand
STONE:
	+50 Chips
	No rank or suit
	Card always scores
GOLD:
	$3 if this card is held in hand at end of round
LUCKY:
	1 in 5 chance for +20 Mult
	1 in 15 chance to win $20
	(Both can trigger on the same turn)
"""
enum CardAttributes {
	BASE, 
	BONUS, 
	MULT, 
	WILD, 
	GLASS, 
	STEEL, 
	STONE, 
	GOLD, 
	LUCKY
}

"""
BASE:
	No extra effects
GOLD:
	Earn $3 when this card is played and scores
RED:
	Retrigger this card 1 time. As well as when being scored in a poker hand.
BLUE:
	If this card is held at end of round, it creates the Planet card matching the final poker hand played, if you have room
PURPLE:
	Creates a Tarot card when discarded, if you have room. Can be from player-elected discards, or from the automatic discard of The Hook boss blind.
"""
enum CardSeals {
	BASE, 
	GOLD, 
	RED, 
	BLUE, 
	PURPLE
}

"""
https://balatrogame.fandom.com/wiki/Poker_Hands
"""
enum HandTypes {
	FlushFive,
	FlushHouse,
	FiveOfAKind,
	RoyalFlush,
	StraightFlush,
	FourOfAKind,
	FullHouse,
	Flush,
	Straight,
	ThreeOfAKind,
	TwoPair,
	Pair,
	HighCard
}

enum Parents {
	GAME,
	PLAYER_ONE,
	PLAYER_TWO,
	PLAYER_THREE,
	PLAYER_FOUR
	
}
