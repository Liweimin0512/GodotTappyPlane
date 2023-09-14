extends MarginContainer

@onready var btn_quit: TextureButton = %btn_quit
@onready var btn_retry: TextureButton = %btn_retry
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer

signal btn_quit_pressed
signal btn_retry_pressed


func _ready() -> void:
	btn_quit.pressed.connect(_on_btn_quit_pressed)
	btn_retry.pressed.connect(_on_btn_retry_pressed)


func _on_btn_quit_pressed() -> void:
	audio_stream_player.play()
	btn_quit_pressed.emit()

func _on_btn_retry_pressed() -> void:
	audio_stream_player.play()
	btn_retry_pressed.emit()
