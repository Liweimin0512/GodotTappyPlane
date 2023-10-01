extends ParallaxBackground

## 视差层引用
@onready var parallax_layer: ParallaxLayer = %ParallaxLayer

## 背景移动速度
@export var speed : float = 100

func retry_game() -> void:
	## 每次重试游戏的时候，将视差背景层的偏移量重置
	parallax_layer.motion_offset = Vector2.ZERO


func _process(delta: float) -> void:
	## 在每一帧改变视差层的motion_offset属性的x值即可实现视差背景的滚动效果
	if parallax_layer.motion_offset.x <= parallax_layer.motion_mirroring.x * -1:
		parallax_layer.motion_offset.x = 0
	parallax_layer.motion_offset.x -= delta * speed
