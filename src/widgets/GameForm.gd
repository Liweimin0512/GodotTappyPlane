extends Control

@onready var score_display: Control = $ScoreDisplay
@onready var w_game_over: MarginContainer = %w_game_over

var number_textures = [
	preload("res://assets/testures/widgets/numbers/number0.png"),
	preload("res://assets/testures/widgets/numbers/number1.png"),
	preload("res://assets/testures/widgets/numbers/number2.png"),
	preload("res://assets/testures/widgets/numbers/number3.png"),
	preload("res://assets/testures/widgets/numbers/number4.png"),
	preload("res://assets/testures/widgets/numbers/number5.png"),
	preload("res://assets/testures/widgets/numbers/number6.png"),
	preload("res://assets/testures/widgets/numbers/number7.png"),
	preload("res://assets/testures/widgets/numbers/number8.png"),
	preload("res://assets/testures/widgets/numbers/number9.png"),
]

signal btn_quit_pressed
signal btn_retry_pressed

func _ready() -> void:
	self.visibility_changed.connect(_on_visibility_changed)
	w_game_over.btn_quit_pressed.connect(_on_btn_quit_pressed)
	w_game_over.btn_retry_pressed.connect(_on_btn_retry_pressed)

## 更新分数显示
func update_score_display(current_score : int) -> void:
	var score_str = str(current_score)
	var digit_count = score_str.length()
	for i in range(digit_count):
		var digit = int(score_str[i])
		var digit_sprite : TextureRect
		if score_display.get_child_count() <= i:
			digit_sprite = TextureRect.new()
			score_display.add_child(digit_sprite)
		else:
			digit_sprite = score_display.get_child(i)
		digit_sprite.texture = number_textures[digit]

## 游戏结束
func game_over() -> void:
	w_game_over.show()

func _on_visibility_changed() -> void:
	if self.visible == true:
		w_game_over.hide()
	else:
		w_game_over.hide()

func _on_btn_quit_pressed() -> void:
	btn_quit_pressed.emit()

func _on_btn_retry_pressed() -> void:
	btn_retry_pressed.emit()
