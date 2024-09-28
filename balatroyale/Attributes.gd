class_name attributes
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
enum {
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
