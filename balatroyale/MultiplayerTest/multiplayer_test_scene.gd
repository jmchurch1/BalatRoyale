extends Node2D

var test_player_scene = preload("res://MultiplayerTest/MultiplayerTestPlayer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var players = Lobby.players.values()
	for player in players:
		var player_scene = test_player_scene.instantiate()
		player_scene.init(player)
		add_child(player_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
