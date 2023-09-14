extends Node2D

#@onready var background_parallax_layer: ParallaxLayer = %BackgroundParallaxLayer
#@onready var front_parallax_layer: ParallaxLayer = %FrontParallaxLayer
@onready var entity_root: Node2D = %EntityRoot
@onready var born_point = %Marker2D

@onready var s_player : PackedScene = preload("res://src/entities/plane.tscn")
@onready var s_rock = preload("res://src/entities/Rock.tscn")

@export var scroll_speed = 100 # 滚动速度
#@onready var s_rock_d = preload("res://src/entities/RockDown.tscn")
@onready var player: CharacterBody2D
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer


var rock_max_y = 450
var rock_d_min_y = 200
var rock_y = 239 * 1.2

var timer : Timer = Timer.new()

signal game_overed

func _ready() -> void:
	get_tree().paused = true
	
func _process(delta):
	# 改变偏移以创建滚动效果
#	background_parallax_layer.motion_offset.x += scroll_speed * delta * -0.5
#	front_parallax_layer.motion_offset.x += scroll_speed * delta * -1.2
	if player == null:
		return
	if player.position.y > get_viewport_rect().size.y or player.position.y < 0:
		game_over()

func set_random_timer_time():
	var random_time = randf_range(1.5, 3.0) # 在1~3秒之间随机选择一个时间
	timer.wait_time = random_time # 设置定时器的等待时间

## 重试游戏
func retry_game() -> void:
	# 创建角色
	create_player()
	# 如果当前有rock，全部清除
	for r in get_tree().get_nodes_in_group("rock"):
		r.queue_free()
	# 创建障碍物
	spawn_rock()
	get_tree().paused = false

## 结束游戏
func game_over() ->void:
	get_tree().paused = true
	game_overed.emit()
	player.queue_free()
	audio_stream_player.play()

## 创建角色
func create_player() -> void:
	player = s_player.instantiate()
	entity_root.add_child(player)
	player.position = born_point.position

## 生成障碍物
func spawn_rock() -> void:
	self.add_child(timer) # 将定时器添加为子节点
	timer.timeout.connect(self._on_timer_timeout) # 连接定时器的timeout信号
	set_random_timer_time() # 设置随机时间
	timer.start() # 启动定时器

## 创建障碍物
func create_rock() -> void:
	var random_choice = randi_range(0, 1) # 随机选择0或1
	var new_object

	if random_choice == 0:
		new_object = s_rock.instantiate() # 创建一个Rock实例
		new_object.position.y = randf_range(rock_max_y + rock_y, rock_max_y) # 随机设置Rock的垂直位置
	elif random_choice == 1:
		new_object = s_rock.instantiate()
		new_object.scale *= -1
		new_object.position.y = randf_range(rock_d_min_y, rock_d_min_y - rock_y) #随机位置
#	else:
#		new_object = star_scene.instance() # 创建一个Star实例
#		new_object.position.y = rand_range(100, 400) # 随机设置Star的垂直位置
	new_object.speed = self.scroll_speed
	new_object.position.x = get_viewport_rect().size.x + 40
	entity_root.add_child(new_object) # 将新对象添加为当前节点的子节点
	new_object.rock_hit.connect(_on_rock_hit)
	set_random_timer_time() # 重新设置随机时间
	timer.start() # 重新启动定时器	

func _on_timer_timeout():
	create_rock()

func _on_rock_hit() -> void:
	game_over()

