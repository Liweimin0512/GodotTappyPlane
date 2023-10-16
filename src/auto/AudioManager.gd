extends Node
class_name SoundManager

@export var is_open_audio : bool = false
@export var is_open_music : bool = false

func _ready() -> void:
	set_audio()
	set_music()

func set_audio() -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), !is_open_audio)

func set_music() -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("BGM"), !is_open_music)
