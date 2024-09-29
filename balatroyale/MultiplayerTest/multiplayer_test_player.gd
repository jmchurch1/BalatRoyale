extends Node2D

@onready var rect = $ColorRect
var player_info

func init(_player_info):
	player_info = _player_info
	name = player_info["name"]
	set_multiplayer_authority(int(player_info["id"]))
	print("Spawned in player " + str(player_info["id"]) + " | " + str(player_info["name"]))

func move_only_local_rect(mouse_pos: Vector2):
	#if Lobby.get_my_local_player_id() == player_id:
	rect.position = mouse_pos

func _input(event):
	if not is_multiplayer_authority(): return
   # Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		#print("Mouse Click/Unclick at: ", event.position)
		pass
	elif event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.position)
		move_only_local_rect(event.position)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
