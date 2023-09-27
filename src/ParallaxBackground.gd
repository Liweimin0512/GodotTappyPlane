extends ParallaxBackground

@export var speed : float = 100

#@onready var background : Sprite2D = get_node("ParallaxLayer/Background")
#@onready var background : Sprite2D = $"ParallaxLayer/Background"
#@onready var background: Sprite2D = %Background
@onready var parallax_layer: ParallaxLayer = %ParallaxLayer

func retry_game() -> void:
	parallax_layer.motion_offset = Vector2.ZERO

func _process(delta: float) -> void:
	parallax_layer.motion_offset.x -= delta * speed
