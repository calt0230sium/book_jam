extends Control


@export var music_button_on_texture: Texture
@export var music_button_off_texture: Texture
@export var sfx_button_on_texture: Texture
@export var sfx_button_off_texture: Texture

@onready var music_button = $MusicButton
@onready var sfx_button = $SFXButton

# Called when the node enters the scene tree for the first time.
func _ready():
	SoundManager.play_sound("placeholder_music", true)


func _on_music_button_gui_input(_event):
	if Input.is_action_just_released("left_click"):
		if SoundManager.music_is_mute():
			SoundManager.mute_music(false)
			music_button.texture = music_button_on_texture
		else:
			SoundManager.mute_music(true)
			music_button.texture = music_button_off_texture

func _on_sfx_button_gui_input(_event):
	if Input.is_action_just_released("left_click"):
		if SoundManager.sound_effects_are_mute():
			print("mute")
			SoundManager.mute_sound_effects(false)
			sfx_button.texture = sfx_button_on_texture
		else:
			print("not mute")
			SoundManager.mute_sound_effects(true)
			sfx_button.texture = sfx_button_off_texture
