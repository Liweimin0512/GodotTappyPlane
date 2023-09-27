extends Control

@onready var score_container: HBoxContainer = %ScoreContainer
@onready var w_game_over_popup: MarginContainer = %w_game_over_popup

var number_textures = [
	preload("res://assets/textures/widgets/numbers/number0.png"), 
	preload("res://assets/textures/widgets/numbers/number1.png"), 
	preload("res://assets/textures/widgets/numbers/number2.png"), 
	preload("res://assets/textures/widgets/numbers/number3.png"), 
	preload("res://assets/textures/widgets/numbers/number4.png"), 
	preload("res://assets/textures/widgets/numbers/number5.png"), 
	preload("res://assets/textures/widgets/numbers/number6.png"), 
	preload("res://assets/textures/widgets/numbers/number7.png"), 
	preload("res://assets/textures/widgets/numbers/number8.png"), 
	preload("res://assets/textures/widgets/numbers/number9.png")
]

signal quit_pressed
signal retry_pressed
signal w_name_imput_popup_confirm(player_name: String)

func _ready() -> void:
	w_game_over_popup.hide()
	%w_name_input_popup.hide()

## 重试游戏
func retry_game() -> void:
	w_game_over_popup.hide()

## 结束游戏
func game_over() -> void:
	w_game_over_popup.show()

## 更新分数显示 
func update_score_display(current_score: int) -> void:
	var score_str : String = str(current_score)
	var digit_count = score_str.length()
	for i in range(digit_count):
		var digit = int(score_str[i])
		var digit_sprite : TextureRect
		if score_container.get_child_count() <= i:
			digit_sprite = TextureRect.new()
			score_container.add_child(digit_sprite)
		else:
			digit_sprite = score_container.get_child(i)
		digit_sprite.texture = number_textures[digit]

## 显示玩家输入弹窗
func show_name_input_popup() -> void:
	%w_name_input_popup.show()

func _on_btn_quit_pressed() -> void:
	quit_pressed.emit()


func _on_btn_retry_pressed() -> void:
	retry_pressed.emit()


func _on_w_name_input_popup_btn_confirm_pressed(player_name: String) -> void:
	w_name_imput_popup_confirm.emit(player_name)
	w_game_over_popup.show()


func _on_w_name_input_popup_btn_quit_pressed() -> void:
	w_game_over_popup.show()
