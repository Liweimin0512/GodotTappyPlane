extends Node
class_name BaseStateMachine

## 一个简单的有限状态机实现

## 当前状态：注意这是一个枚举值，在具体的实现类中定义
var current_state : int = 0
## 状态集：使用一个字段维护所有状态，Key是枚举值（int）,Value是BaseState的实现类
var states : Dictionary = {}

## 当前状态机的代理，可以在编辑器或运行时设置，这对于在状态机中调用代理的方法很有用
@export var agent : Node
## 判断当前状态机是否正在运行，TODO实现启动、暂停和恢复状态机执行的方法
var is_run : bool = false

func _enter_tree() -> void:
	self.process_mode = PROCESS_MODE_ALWAYS

func _process(delta: float) -> void:
	if is_run and states[current_state]:
		states[current_state].update(delta)

## 启动状态机
func launch(state_type : int = 0) -> void:
	assert(agent, '代理不能为空！')
	is_run = true
	var state = states[state_type]
	state.enter()

## 添加状态
func add_state(state_type : int, state : BaseState) -> void:
	states[state_type] = state


## 根据名称设置属性的值
func set_value(name : StringName, value : Variant) -> void:
	var cs = states[current_state]
	if cs != null and name in cs:
		cs.set(name, value)

## 根据名称获取属性的值
func get_value(name: StringName) -> Variant:
	var cs = states[current_state]
	if cs != null and name in cs:
		return cs.get(name)
	return null
