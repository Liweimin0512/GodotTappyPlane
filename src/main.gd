extends Node2D
class_name Main

@onready var game: Node2D = %game
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer
@onready var ui_layer: CanvasLayer = %UILayer
@onready var game_state_machine: GameStateMachine = %GameStateMachine

var score_timer : Timer = Timer.new()
var current_score : float = 0 : 
	set(value):
		ui_layer.update_score_display(value)
		current_score = value

func _ready() -> void:
	self.add_child(score_timer)
	score_timer.timeout.connect(self._on_score_timer_timeout)
	ui_layer.new_game_pressed.connect(_on_ui_layer_new_game_pressed)
	ui_layer.btn_quit_pressed.connect(_on_ui_layer_btn_quit_pressed)
	ui_layer.btn_retry_pressed.connect(_on_ui_layer_btn_retry_pressed)
	ui_layer.w_name_input_popup_confirm_pressed.connect(_on_ui_layer_w_name_input_popup_confirm_pressed)
	game.game_overed.connect(_on_game_game_overed)
	game_state_machine.launch()

## 初始化游戏数据
func init_game() -> void:
	LeaderBoard.load_leaderboard()

## 准备开始游戏，显示menu_form
func ready_game() -> void:
#	if ui_layer == null:
#		ui_layer = %UILayer
	ui_layer.show_menu_form()

## 重新开始游戏
func retry_game() -> void:
	current_score = 0
	score_timer.wait_time = 1
	score_timer.start()
	game.retry_game()
	ui_layer.show_game_form()
#	game_form.retry_game()
	audio_stream_player.play()

## 暂停游戏
func pause_game() -> void:
	pass

## 结束游戏
func end_game() -> void:
	if LeaderBoard.check_leaderboard(current_score):
		ui_layer.show_name_input_popup()
	else:
		ui_layer.end_game()

## 退出游戏
func quit_game() -> void:
	get_tree().quit()

func update_score() -> void:
	current_score += 1

func _on_ui_layer_new_game_pressed() -> void:
	game_state_machine.set_value("is_new_game", true)

func _on_ui_layer_btn_quit_pressed() -> void:
	game_state_machine.set_value('is_quit_game', true)

func _on_ui_layer_btn_retry_pressed() -> void:
	game_state_machine.set_value('is_retry_game', true)

func _on_ui_layer_w_name_input_popup_confirm_pressed(name: String) -> void:
	if LeaderBoard.check_leaderboard(current_score):
		LeaderBoard.update_leaderboard(name, current_score)

func _on_score_timer_timeout() -> void:
	update_score()

func _on_game_game_overed() -> void:
	game_state_machine.set_value('is_game_over', true)
