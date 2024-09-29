extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Lobby.player_connected.connect(lobby_ui_on_player_connected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func lobby_ui_on_player_connected(player_id, player_info):
	update_connected_players_ui()

func update_connected_players_ui():
	var num_players_loaded = Lobby.players.size()
	if num_players_loaded > 1 and multiplayer.is_server():
		$StartGame.visible = true
	var connected_players_names = ""
	for player in Lobby.players.values():
		if "name" in player:
			connected_players_names += player["name"] + "\n"
	if $ConnectedPlayers != null:
		$ConnectedPlayers.text = "Connected Players: " + str(num_players_loaded) + "\n" + connected_players_names
	

#we need these passthrough button funcs so that our Lobby can stay an Autoload global

func _on_join_pressed():
	var ip_to_join = $EnterIPAddressToJoin.text
	var player_name = $EnterNameHere.text
	Lobby._on_join_pressed(ip_to_join, player_name)


func _on_create_pressed():
	var player_name = $EnterNameHere.text
	Lobby._on_create_pressed(player_name)


func _on_start_game_pressed():
	Lobby._on_start_game_pressed()
