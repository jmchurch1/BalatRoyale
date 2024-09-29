extends Control

# to actually host/join online lobbies that aren't on your local network, see
# https://docs.godotengine.org/en/stable/tutorials/networking/high_level_multiplayer.html#hosting-considerations
# you'll need to port forward the PORT below
# and use your public-facing ip: https://icanhazip.com/

# Autoload named Lobby

const SCENE_TO_LOAD_INTO_AFTER_LOBBY = "res://MultiplayerTest/MultiplayerTestScene.tscn"

# These signals can be connected to by a UI lobby scene or the game scene.
signal player_connected(peer_id, player_info)
signal player_disconnected(peer_id)
signal server_disconnected

const PORT = 7000
const DEFAULT_SERVER_IP = "127.0.0.1" # localhost
const MAX_CONNECTIONS = 4

# This will contain player info for every player,
# with the keys being each player's unique IDs.
var players = {}

# This is the local player info. This should be modified locally
# before the connection is made. It will be passed to every other peer.
# For example, the value of "name" can be set to something the player
# entered in a UI scene.
var player_info = {}

var players_loaded = 0

func _ready():
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connected_fail)
	multiplayer.server_disconnected.connect(_on_server_disconnected)


func join_game(address = ""):
	if address.is_empty():
		address = DEFAULT_SERVER_IP
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(address, PORT)
	if error:
		OS.alert("Failed to start multiplayer client. Likely tried to connect to a bad IP")
		return error
	multiplayer.multiplayer_peer = peer
	_register_player(player_info)

func create_game():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(PORT, MAX_CONNECTIONS)
	if error:
		OS.alert("Failed to start multiplayer server.")
		return error
	multiplayer.multiplayer_peer = peer
	print("Created multiplayer server")
	# server ID is always 1
	_register_player(player_info)


func remove_multiplayer_peer():
	multiplayer.multiplayer_peer = null


# When the server decides to start the game from a UI scene,
# do Lobby.load_game.rpc(filepath)
@rpc("call_local", "reliable")
func load_game(game_scene_path):
	get_tree().change_scene_to_file(game_scene_path)

func start_game():
	print("Starting the game!")
	Lobby.load_game.rpc(SCENE_TO_LOAD_INTO_AFTER_LOBBY)

# This signal is emitted with the newly connected peer's ID on each other peer, 
# and on the new peer multiple times, once with each other peer's ID
func _on_player_connected(id):
	_register_player.rpc_id(id, player_info)


@rpc("any_peer", "call_local", "reliable")
func _register_player(new_player_info):
	# sometimes for some reason we get a blank dictionary and double connection messages
	if new_player_info.size() == 0:
		return
	var new_player_id = multiplayer.get_remote_sender_id()
	if new_player_id == 0: # remote_sender_id is 0 when we call this function locally
		new_player_id = get_my_local_player_id()
	new_player_info["id"] = new_player_id # intentional redundancy
	players[new_player_id] = new_player_info
	print("[" + str(get_my_local_player_id()) + "] player connected: " + str(new_player_id) + " | " + str(new_player_info))
	if multiplayer.is_server():
		var num_players_loaded = players.size()
		print("[Server] Players loaded = " + str(num_players_loaded))
		if num_players_loaded >= MAX_CONNECTIONS:
			start_game()
	player_connected.emit(new_player_id, new_player_info)

# This signal is emitted on every remaining peer when one disconnects
func _on_player_disconnected(id):
	print("player disconnected: " + str(id))
	players.erase(id)
	player_disconnected.emit(id)

# only emitted on client
func _on_connected_to_server():
	var peer_id = multiplayer.get_unique_id()
	#players[peer_id] = player_info
	#print("player client connected to server: " + str(peer_id) + " | " + str(player_info))
	#player_connected.emit(peer_id, player_info)

# only emitted on client
func _on_connected_fail():
	print("Client failed to connect to server")
	multiplayer.multiplayer_peer = null

# only emitted on client
func _on_server_disconnected():
	var peer_id = multiplayer.get_unique_id()
	#print("player client disconnected from server " + str(peer_id) + " | " + str(player_info))
	#multiplayer.multiplayer_peer = null
	#players.clear()
	#server_disconnected.emit()

func set_local_player_info(player_name, default_name = "Nameless"):
	if player_name.is_empty():
		player_name = default_name
	player_info["name"] = player_name
	print("set player name " + player_info["name"])

#returns local player id. Used to index into players dictionary
func get_my_local_player_id():
	return multiplayer.get_unique_id()

func get_my_local_player_info():
	return players[get_my_local_player_id()]

func get_all_peers():
	return multiplayer.get_peers()
	
func get_players():
	return players

func _on_create_pressed(player_name):
	set_local_player_info(player_name, "Host")
	create_game()

func _on_join_pressed(ip_to_join, player_name):
	set_local_player_info(player_name, "Client")
	join_game(ip_to_join)


func _on_start_game_pressed():
	start_game()
