extends BaseStateMachine
class_name GameStateMachine

## 游戏流程状态机：负责管理整个游戏的流程。使用状态机管理游戏流程能使整个流程更清晰

## 游戏流程状态枚举
enum GAME_STATE_TYPE {
	INIT, 	## 初始化状态
	READY, 	## 准备状态 MenuForm
	PLAYING,## 游戏进行中状态
	PAUSE, 	## 游戏暂停状态
	END,	## 游戏结束状态
}

## 初始化操作
class InitState:
	extends	BaseState
	func enter(_msg:Dictionary = {}) -> void:
#		print("enter init state")
		agent.init_game()
		transition_to(GAME_STATE_TYPE.READY)

## 准备状态，显示MenuForm
class ReadyState:
	extends	BaseState
	var is_new_game : bool = false
	var is_quit_game : bool = false
	
	func enter(_msg:Dictionary = {}) -> void:
#		print("enter ready state")
		agent.ready_game()
	
	func exit() -> void:
		set_fsm_variable('is_new_game', false)
		set_fsm_variable('is_quit_game', false)
	
	func update(detla : float) -> void:
		if has_fsm_variable('is_new_game'):
			is_new_game = get_fsm_variable('is_new_game')
		if has_fsm_variable('is_quit_game'):
			is_quit_game = get_fsm_variable('is_quit_game')
		if is_new_game:
			transition_to(GAME_STATE_TYPE.PLAYING)
		if is_quit_game:
			transition_to(GAME_STATE_TYPE.END)

## 实际的游戏状态
class PlayingState:
	extends	BaseState
	var is_over_game: bool = false
	var is_retry_game: bool = false
	func enter(_msg:Dictionary = {}) -> void:
#		print("enter playing state")
		agent.retry_game()
	
	func exit() -> void:
		set_fsm_variable('is_over_game', false)
		set_fsm_variable('is_retry_game', false)
	
	func update(detla : float) -> void:
		if has_fsm_variable('is_over_game'):
			is_over_game = get_fsm_variable('is_over_game')
		if has_fsm_variable('is_retry_game'):
			is_retry_game = get_fsm_variable('is_retry_game')
		if is_over_game:
			transition_to(GAME_STATE_TYPE.READY)
		if is_retry_game:
			transition_to(GAME_STATE_TYPE.PLAYING)

class PauseState:
	extends	BaseState
	# 这里给大家留个作业吧，实现在游戏过程中的暂停方法。

class EndState:
	extends	BaseState
	func enter(_msg:Dictionary = {}) -> void:
#		print("enter end state")
		agent.end_game()

func _ready() -> void:
	add_state(GAME_STATE_TYPE.INIT, InitState.new(self))
	add_state(GAME_STATE_TYPE.READY, ReadyState.new(self))
	add_state(GAME_STATE_TYPE.PLAYING, PlayingState.new(self))
	add_state(GAME_STATE_TYPE.PAUSE, PauseState.new(self))
	add_state(GAME_STATE_TYPE.END, EndState.new(self))
