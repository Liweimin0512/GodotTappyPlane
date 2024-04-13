extends CharacterBody2D

## 这是主角控制的飞机的逻辑实现，需要一个向下的重力，以及监听玩家flap动作的输入，施加一个向上的力。

## flap时播放的音效节点
@onready var audio_flap: AudioStreamPlayer = $audio_flap

## 重力配置
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

## 最小倾斜角度
@export var min_tilt_angle: int = -45 
## 最大倾斜角度
@export var max_tilt_angle: int = 45
## 向上的力
@export var flap_power = 200
## y方向最大速度
@export var max_velocity_y: int = 200

func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity.y += gravity * delta
	# 设置当前的倾斜角度
	var tilt_angle = clamp((velocity.y / gravity) * max_tilt_angle, -360, max_tilt_angle)
	self.rotation_degrees = tilt_angle
	# 位移
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("flap"):
		# 检测到未被处理的flap事件后
		flap()

## 襟翼
func flap() -> void:
	self.velocity.y = clamp(self.velocity.y - flap_power, max_velocity_y * -1, max_velocity_y)
	audio_flap.play()
