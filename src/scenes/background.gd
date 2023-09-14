extends Sprite2D

@export var speed : float = 80
var max_x : float

func _ready() -> void:
	max_x = round(self.texture.get_width() * scale.x * 100) / 100

func _process(delta: float) -> void:
	move(delta)

func move(delta : float) -> void:
	self.position.x -= delta * speed
	if self.position.x <= max_x * -1 :
		self.position.x = max_x - 1
