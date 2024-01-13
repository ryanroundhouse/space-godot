extends Node

var audio_players = []
var max_audio_players = 10
var bgm_player = AudioStreamPlayer.new()
var max_distance = 1500

func _ready():
	for i in range(max_audio_players):
		var player = AudioStreamPlayer.new()
		add_child(player)
		audio_players.append(player)
	add_child(bgm_player)

func play_sound(sound_path, sound_position, player_position):
	var player = _get_available_player()
	if player:
		player.stream = load(sound_path)
		var distance = sound_position.distance_to(player_position)
		var volume = max(0, 1 - distance / max_distance)  # Adjust 'max_distance' as needed
		player.volume_db = linear2db(volume)  # Convert linear volume to decibels
		player.play()

func play_bgm(bgm_path):
	if not bgm_player.is_playing():
		bgm_player.stream = load(bgm_path)
		bgm_player.play()

func stop_bgm():
	bgm_player.stop()

func _get_available_player():
	for player in audio_players:
		if not player.is_playing():
			return player
	return null

# Helper function to convert linear volume to decibels
func linear2db(linear):
	if linear > 0:
		return 20.0 * log(linear) / log(10.0)
	return -80.0  # Minimum decibel value in Godot
