extends MarginContainer

#@onready var medalGold = preload("res://assets/testures/widgets/medalGold.png")
#@onready var medalSilver = preload("res://assets/testures/widgets/medalSilver.png")
#@onready var medalBronze = preload("res://assets/testures/widgets/medalBronze.png")
@onready var tr_medal: TextureRect = %tr_medal
@onready var lab_score: Label = %lab_score
@onready var lab_name: Label = %lab_name
@onready var mc_data: MarginContainer = %mc_data
@onready var label_empty: Label = %label_empty

@export var medal_texture : Texture = null

func _ready() -> void:
	tr_medal.texture = medal_texture
	

func update_rank(name:String, score:int) -> void:
	if score != 0 and score != null:
		label_empty.hide()
		mc_data.show()
	else:
		label_empty.show()
		mc_data.hide()
	self.lab_name.text = "name: " + name
	self.lab_score.text = "score: " + str(score)
