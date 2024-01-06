extends Node

var audio_players = []
var max_audio_players = 10
var bgm_player = AudioStreamPlayer.new()

func _ready():
	for i in range(max_audio_players):
		var player = AudioStreamPlayer.new()
		add_child(player)
		audio_players.append(player)
	add_child(bgm_player)

func play_sound(sound_path):
	var player = _get_available_player()
	if player:
		player.stream = load(sound_path)
		player.play()

func play_bgm(bgm_path):
	bgm_player.stream = load(bgm_path)
	bgm_player.play()

func stop_bgm():
	bgm_player.stop()

func _get_available_player():
	for player in audio_players:
		if not player.is_playing():
			return player
	return null
