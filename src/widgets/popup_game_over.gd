extends UIPopup
class_name PopupGameOver

@onready var btn_quit: TextureButton = %btn_quit
@onready var btn_retry: TextureButton = %btn_retry

#signal quit_pressed
#signal retry_pressed

const signal_quit: StringName = "popup_game_over_quit_game"
const signal_retry: StringName = "popup_game_over_retry_game"

func _ready() -> void:
	btn_quit.pressed.connect(_on_btn_quit_pressed)
	btn_retry.pressed.connect(_on_btn_retry_pressed)

func _on_btn_quit_pressed() -> void:
#	ui_manager.close_current_interface()
#	quit_pressed.emit()
	ui_manager.emit(signal_quit, [])

func _on_btn_retry_pressed() -> void:
#	ui_manager.close_current_interface()
#	retry_pressed.emit()
	ui_manager.emit(signal_retry, [])
