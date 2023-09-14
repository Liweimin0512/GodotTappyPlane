extends Control

@onready var toggle_sfx : TextureButton = %btn_sound
@onready var sfx_slider : HSlider = %sfx_slider
@onready var toggle_bgm : TextureButton = %btn_music
@onready var bgm_slider : HSlider = %bgm_slider
@onready var audio_click: AudioStreamPlayer = %AudioClick
@onready var btn_confirm: TextureButton = %btn_confirm

var is_open_bgm: bool = true
var is_open_sfx: bool = true

@onready var audioOff = preload("res://assets/testures/widgets/icons/audioOff.png")
@onready var audioOn = preload("res://assets/testures/widgets/icons/audioOn.png")
@onready var musicOff = preload("res://assets/testures/widgets/icons/musicOff.png")
@onready var musicOn = preload("res://assets/testures/widgets/icons/musicOn.png")

signal confirm_pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bgm_slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("BGM"))
	sfx_slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))

# 更新背景音乐音量
func _on_BGM_VolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"), value)

# 更新音效音量
func _on_SFX_VolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)


func _on_btn_sound_pressed() -> void:
	is_open_sfx = !is_open_sfx
	if is_open_sfx:
		toggle_sfx.texture_normal = audioOn
	else:
		toggle_sfx.texture_normal = audioOff
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), !is_open_sfx)
	audio_click.play()

func _on_btn_music_pressed() -> void:
	is_open_bgm = !is_open_bgm
	if is_open_bgm:
		toggle_bgm.texture_normal = musicOn
	else:
		toggle_bgm.texture_normal = musicOff
	AudioServer.set_bus_mute(AudioServer.get_bus_index("BGM"), !is_open_bgm)
	audio_click.play()


func _on_btn_confirm_pressed() -> void:
	confirm_pressed.emit()
