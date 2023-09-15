extends Control

@onready var btn_confirm: TextureButton = %btn_confirm
@onready var rank_list: VBoxContainer = %rank_list

signal confirm_pressed

func _ready() -> void:
	btn_confirm.pressed.connect(_on_btn_confirm_pressed)
	self.visibility_changed.connect(_on_visibility_changed)

func _on_btn_confirm_pressed() -> void:
	confirm_pressed.emit()

func _on_visibility_changed() -> void:
	if self.visible == true:
		for i in rank_list.get_children().size():
			var name = LeaderBoard.leaderboard[i].name
			var score = LeaderBoard.leaderboard[i].score
			var w_rank = rank_list.get_child(i)
			w_rank.update_rank(name, score)
