extends Node
class_name BaseStateMachine

var current_state_index : int = 0
var current_state : BaseState :
	get:
		return states[current_state_index]

var states : Dictionary = {}
## 状态机代理
@export var agent : Node

var is_run : bool = false
var values : Dictionary = {}

func _enter_tree() -> void:
	self.process_mode == PROCESS_MODE_ALWAYS

func _process(delta: float) -> void:
	current_state.update(delta)

func launch(state_index : int = 0) -> void:
	assert(agent, '代理不能为空！')
	is_run = true
#	current_state = states[state_index]
	current_state.enter()

## 添加状态
func add_state(state_type : int, state : BaseState) -> void:
	states[state_type] = state

## 根据名称设置属性的值
func set_value(name : StringName, value : Variant) -> void:
	values[name] = value

## 根据名称获取属性的值
func get_value(name: StringName) -> Variant:
	if values.has(name):
		return values[name]
	return null

## 是否存在属性
func has_value(name: StringName) -> bool:
	return values.has(name)
