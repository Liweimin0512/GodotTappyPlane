extends Control


signal btn_new_game_pressed
signal btn_settings_pressed
signal btn_rank_pressed
signal btn_quit_pressed

@onready var margin_container: MarginContainer = %MarginContainer
@onready var w_settings_popup: MarginContainer = %w_settings_popup
@onready var w_rank_popup: MarginContainer = %w_rank_popup

func _on_btn_new_game_pressed() -> void:
	btn_new_game_pressed.emit()

func _on_btn_settings_pressed() -> void:
	margin_container.hide()
	w_settings_popup.show()
	btn_settings_pressed.emit()

func _on_btn_rank_pressed() -> void:
	margin_container.hide()
	w_rank_popup.show()
	btn_rank_pressed.emit()
	w_rank_popup.update_rank_board()

func _on_btn_quit_pressed() -> void:
	btn_quit_pressed.emit()

func _on_w_settings_popup_confirm_pressed() -> void:
	margin_container.show()
	w_settings_popup.hide()

func _on_w_rank_popup_btn_confirm_pressed() -> void:
	margin_container.show()
	w_rank_popup.hide()
