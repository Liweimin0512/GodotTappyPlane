extends RefCounted
class_name BaseState

var state_machine = null
var agent: Node = null :
	get:
		assert(state_machine and state_machine.agent, '状态机或代理不存在！')
		return state_machine.agent

func _init(machine: BaseStateMachine) -> void:
	state_machine = machine

func enter(_msg : Dictionary = {}) -> void:
	pass

func exit() -> void:
	pass

func update(delta : float) -> void:
	pass

func transition_to(state_index: int, msg:Dictionary = {}) -> void:
	state_machine.current_state.exit()
	state_machine.current_state_index = state_index
	state_machine.current_state.enter(msg)
	
