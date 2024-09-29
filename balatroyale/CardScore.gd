class_name CardScore

var money :int
var value :int
var mult :float

func _init(newMoney :int, newValue :int, newMult: float):
	money = newMoney
	value = newValue
	mult = newMult

func addMult(multType, newMult):
	match multType:
		Enums.MultType.MULTIPLY:
			mult *= newMult
		Enums.MultType.ADD:
			mult += newMult
		_:
			print("MultType not recognized")


func _to_string() -> String:
	var return_string = "%s X %s \n Money: %s"
	return return_string % [String.num_int64(value), String.num(mult), String.num_int64(money)]
