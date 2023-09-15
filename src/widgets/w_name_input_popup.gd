extends Control

@onready var te_name: TextEdit = %te_name
@onready var btn_quit: TextureButton = %btn_quit
@onready var btn_confirm: TextureButton = %btn_confirm

signal quit_pressed
signal confirm_pressed

func _ready() -> void:
	btn_quit.pressed.connect(_on_btn_quit_pressed)
	btn_confirm.pressed.connect(_on_btn_confirm_pressed)
	
func _on_btn_quit_pressed() -> void:
	quit_pressed.emit()
	
func _on_btn_confirm_pressed() -> void:
	if not te_name.text.is_empty():
		confirm_pressed.emit(te_name.text)
