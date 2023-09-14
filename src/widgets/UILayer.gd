extends CanvasLayer

@onready var game_form: Control = %GameForm
@onready var menu_form: Control = %MenuForm
@onready var w_settings: Control = %w_settings

signal new_game_pressed
signal btn_quit_pressed
signal btn_retry_pressed

func _ready() -> void:
	menu_form.new_game_pressed.connect(_on_new_game_pressed)
	menu_form.settings_pressed.connect(_on_menu_form_settings_pressed)
	w_settings.confirm_pressed.connect(_on_w_settings_confirm_pressed)
	game_form.btn_quit_pressed.connect(_on_game_form_btn_quit_pressed)
	game_form.btn_retry_pressed.connect(_on_game_form_btn_retry_pressed)
	
func hide_all_form() -> void:
	for c in get_children():
		c.hide()

func show_game_form() -> void:
	hide_all_form()
	game_form.show()

func show_menu_form() -> void:
	hide_all_form()
	menu_form.show()

func end_game() -> void:
	game_over()

func game_over() -> void:
	game_form.game_over()

func update_score_display(value : int) -> void:
	game_form.update_score_display(value)


func _on_new_game_pressed() -> void:
	new_game_pressed.emit()

func _on_menu_form_settings_pressed() -> void:
	hide_all_form()
	w_settings.show()

func _on_w_settings_confirm_pressed() -> void:
	show_menu_form() 

func _on_game_form_btn_quit_pressed() -> void:
	btn_quit_pressed.emit()

func _on_game_form_btn_retry_pressed() -> void:
	btn_retry_pressed.emit()
