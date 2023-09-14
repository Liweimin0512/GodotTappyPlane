extends CharacterBody2D

@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer

@export var gravity = 300
@export var min_tilt_angle = -45 # 最小倾斜角度
@export var max_tilt_angle = 45 # 最大倾斜角度
@export var flap_power = -200 # 向上的力
var vertical_speed = 0 : # 垂直速度
	set(value):
		velocity.y = value
		vertical_speed = value

func _physics_process(delta):
	if gravity == 0:
		return
	vertical_speed += gravity * delta
	# 计算倾斜角度，基于垂直速度
	var tilt_angle = clamp((vertical_speed / gravity) * max_tilt_angle, min_tilt_angle,max_tilt_angle)

	# 设置旋转角度
	rotation_degrees = tilt_angle
	
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("flap"):
		vertical_speed = flap_power # 给飞机一个向上的力
		audio_stream_player.play()
