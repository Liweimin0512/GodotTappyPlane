extends Control

@onready var btn_new_game: TextureButton = %btn_new_game
@onready var btn_setting: TextureButton = %btn_setting
@onready var btn_ranking: TextureButton = %btn_ranking
@onready var btn_quit: TextureButton = %btn_quit

@onready var audio_click: AudioStreamPlayer = %AudioClick

signal new_game_pressed
signal settings_pressed
signal ranking_pressed

func _ready() -> void:
	btn_new_game.pressed.connect(_on_btn_new_game_pressed)
	btn_setting.pressed.connect(_on_btn_setting_pressed)
	btn_ranking.pressed.connect(_on_btn_ranking_pressed)
	btn_quit.pressed.connect(_on_btn_quit_pressed)

## 开始新游戏，切换游戏状态
func _on_btn_new_game_pressed() -> void:
	audio_click.play()
	new_game_pressed.emit()
	
## 弹出设置弹窗，可以进行简单的游戏设置
func _on_btn_setting_pressed() -> void:
	audio_click.play()
	settings_pressed.emit()

## 显示排行榜弹窗，弹窗中显示当前本地保存的前三名记录
func _on_btn_ranking_pressed() -> void:
	audio_click.play()
	ranking_pressed.emit()

## 退出游戏
func _on_btn_quit_pressed() -> void:
	audio_click.play()
	get_tree().quit()
