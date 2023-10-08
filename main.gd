extends Node2D

@onready var plane: CharacterBody2D = null
@onready var audio_game_over: AudioStreamPlayer = $audio_game_over
@onready var game_state_machine: GameStateMachine = %GameStateMachine
@onready var ui_layer: CanvasLayer = %UILayer


var s_plane : PackedScene = preload("res://src/entities/plane.tscn")
var timer : Timer = Timer.new()
@export var min_spawn_rock_time : float = 1.0
@export var max_spawn_rock_time : float = 3.0

var s_rock : PackedScene = preload("res://src/entities/rock.tscn")
var current_score : int = 0
var score_timer : Timer = Timer.new()

func _ready() -> void:
	game_state_machine.launch()

func _process(delta: float) -> void:
	if not plane:
		return
	if plane.position.y <= 0 or plane.position.y >= get_viewport_rect().size.y:
		game_over()

## 初始化操作
func init_game() -> void:
	RankBoard.load_rank_board()

func ready_game() -> void:
	ui_layer.ready_game()

## 开始新游戏
func new_game() -> void:
	game_state_machine.set_variable('is_new_game', true)

## 重试游戏
func retry_game() -> void:
	if not plane:
		plane = s_plane.instantiate()
		plane.position = Vector2(72, 152)
		self.add_child(plane)
	timer.timeout.connect(_on_timer_timeout)
	timer.wait_time = randf_range(min_spawn_rock_time, max_spawn_rock_time)
	self.add_child(timer)
	timer.one_shot = true
	timer.start()
	current_score = 0
#	game_form.update_score_display(current_score)
	score_timer.timeout.connect(_on_score_timer_timeout)
	score_timer.wait_time = 1
	self.add_child(score_timer)
	score_timer.start()
#	game_form.retry_game()
	ui_layer.update_score_display(current_score)
	ui_layer.retry_game()
	%ParallaxBackground.retry_game()
	get_tree().paused = false

## 退出游戏
func quit_game() -> void:
	game_state_machine.set_variable('is_quit_game', true)

## 退出程序
func end_game() -> void:
	get_tree().quit()

func spawn_rock() -> void:
	var random_choice = randi_range(0, 1)
	var rock: Node2D = s_rock.instantiate()
	# 将rock和plane的撞击信号，绑定在对应的方法上
	rock.rock_entered.connect(_on_rock_entered)
	if random_choice == 0:
		rock.position = Vector2(632, randf_range(216, 336))
	else:
		rock.rotation_degrees = 180
		rock.position = Vector2(632, randf_range(-24, 112))
#	print("spawn_rock wait_time:" , timer.wait_time)
	self.add_child(rock)

## 游戏失败
func game_over() -> void:
#	get_tree().quit()
	get_tree().paused = true
	plane.queue_free() # 销毁小飞机
	for rock in get_tree().get_nodes_in_group("rock"):
		rock.queue_free() # 销毁所有的障碍物
#	game_form.game_over()
	if RankBoard.check_rank_board(current_score):
		ui_layer.show_name_input_popup()
	else:
		ui_layer.game_over()
	audio_game_over.play()
#	print_debug("game_over")

func _on_timer_timeout() -> void:
	spawn_rock()
	timer.wait_time = randf_range(min_spawn_rock_time, max_spawn_rock_time)
	timer.start()

func _on_rock_entered() -> void:
	game_over()

func _on_score_timer_timeout() -> void:
	current_score += 1
#	game_form.update_score_display(current_score)
	ui_layer.update_score_display(current_score)

func _on_ui_layer_btn_new_game_pressed() -> void:
	new_game()


func _on_ui_layer_btn_quit_game_pressed() -> void:
	quit_game()


func _on_ui_layer_w_name_imput_popup_confirm(player_name: String) -> void:
	if RankBoard.check_rank_board(current_score):
		RankBoard.update_rank_board(player_name, current_score)


func _on_ui_layer_game_form_quit_game_pressed() -> void:
	game_state_machine.set_variable('is_over_game', true)


func _on_ui_layer_game_form_retry_game_pressed() -> void:
	game_state_machine.set_variable('is_retry_game', true)
