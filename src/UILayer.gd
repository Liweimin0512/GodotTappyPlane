extends CanvasLayer

@onready var menu_form: Control = %MenuForm
@onready var game_form: Control = %GameForm

signal btn_new_game_pressed
signal btn_quit_game_pressed
signal w_name_imput_popup_confirm(player_name: String)
signal game_form_retry_game_pressed
signal game_form_quit_game_pressed

## 准备阶段
func ready_game() -> void:
	menu_form.show()
	game_form.hide()

## 重置游戏
func retry_game() -> void:
	menu_form.hide()
	game_form.show()
	game_form.retry_game()

## 结束游戏
func game_over() -> void:
	game_form.game_over()

## 更新分数的方法
func update_score_display(current_score : int) -> void:
	game_form.update_score_display(current_score)

## 显示玩家的姓名输入框
func show_name_input_popup() -> void:
	game_form.show_name_input_popup()


func _on_menu_form_btn_new_game_pressed() -> void:
	btn_new_game_pressed.emit()


func _on_menu_form_btn_quit_pressed() -> void:
	btn_quit_game_pressed.emit()


func _on_game_form_w_name_imput_popup_confirm(player_name) -> void:
	w_name_imput_popup_confirm.emit(player_name)


func _on_game_form_quit_pressed() -> void:
	game_form_quit_game_pressed.emit()


func _on_game_form_retry_pressed() -> void:
	game_form_retry_game_pressed.emit()
