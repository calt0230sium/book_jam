extends Node

## General sound manager (not spatialised)
## Peut-être qu'on veut que les clients émettent un son spatialisé (c'est pas incompatible)


@export var audio_streams: Dictionary[String, AudioStreamMP3]

var sfx_mute = false
var music_mute = false

## is_music tells if the sound is music or sound_effect
func play_sound(sound_name, is_music=false):
	var audio_player = AudioStreamPlayer.new()
	var bus = "Music" if is_music else "Sound Effects"
	var stream = audio_streams[sound_name]
	stream.loop = is_music
	add_child(audio_player)
	audio_player.bus = bus
	audio_player.stream = stream
	audio_player.finished.connect(_on_player_finished.bind(audio_player))
	audio_player.play()

func _on_player_finished(audio_player):
	audio_player.queue_free()

func music_is_mute():
	return music_mute

func sound_effects_are_mute():
	return sfx_mute

func mute_music(is_muted = true):
	var music_index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_mute(music_index, is_muted)
	music_mute = is_muted
	
func mute_sound_effects(is_muted = true):
	var sfx_index = AudioServer.get_bus_index("Sound Effects")
	AudioServer.set_bus_mute(sfx_index, is_muted)
	sfx_mute = is_muted
