extends BaseStateMachine
class_name GameStateMachine

## 游戏流程状态机：负责管理整个游戏的流程。使用状态机管理游戏流程能使整个流程更清晰

## 游戏流程状态枚举
enum GAME_STATE_TYPE {
	INIT, 	## 初始化状态
	READY, 	## 准备状态
	PLAYING,## 游戏进行中状态
	PAUSE, 	## 游戏暂停状态
	END,	## 游戏结束状态
}

## 进行一些初始化操作，之后跳转到ready状态
class InitState:
	extends BaseState
	func enter(_msg : Dictionary = {}) -> void:
		print("enter init state")
		agent.init_game()
		transition_to(GAME_STATE_TYPE.READY)

## 这个状态显示开始菜单界面，玩家操作开始游戏跳转到playing状态
class ReadyState:
	extends BaseState
	var is_new_game : bool = false
	func enter(_msg : Dictionary = {}) -> void:
		print("enter ready state")
		agent.ready_game()

	func exit() -> void:
		is_new_game = false

	func update(delta: float) -> void:
		if is_new_game:
			_new_game()

	func _new_game() -> void:
		transition_to(GAME_STATE_TYPE.PLAYING)

class PlayingState:
	extends BaseState
	var is_pause : bool = false
	var is_game_over : bool = false
	func enter(_msg : Dictionary = {}) -> void:
		print("enter playing state")
		agent.retry_game()
	
	func exit() -> void:
		is_pause = false
		is_game_over = false

	func update(delta: float) -> void:
		if is_pause:
			pause_game()
		if is_game_over:
			game_over()

	func game_over() -> void:
		transition_to(GAME_STATE_TYPE.END)

	func pause_game() -> void:
		transition_to(GAME_STATE_TYPE.PAUSE)

## 暂停状态，只会和Playing状态相互切换
class PauseState:
	extends BaseState
	var is_pause : bool = true
	func enter(_msg : Dictionary = {}) -> void:
		print("enter pause state")
		agent.pause_game()
	
	func exit() -> void:
		is_pause = true
	
	func update(delta: float) -> void:
		if not is_pause:
			transition_to(GAME_STATE_TYPE.PLAYING)

## 结束游戏GameOver流程，玩家可以选择重新开始或退出游戏（返回开始界面）
class EndState:
	extends BaseState
	var is_quit_game : bool = false
	var is_retry_game : bool = false
	func enter(_msg : Dictionary = {}) -> void:
		print("enter end state")
		agent.end_game()
	
	func exit() -> void:
		is_quit_game = false
		is_retry_game = false

	func update(delta: float) -> void:
		if is_quit_game:
			_quit_game()
		elif is_retry_game:
			_retry_game()

	func _quit_game() -> void:
		transition_to(GAME_STATE_TYPE.READY)
	
	func _retry_game() -> void:
		transition_to(GAME_STATE_TYPE.PLAYING)

func _ready() -> void:
	self.add_state(GAME_STATE_TYPE.INIT, InitState.new(self))
	self.add_state(GAME_STATE_TYPE.READY, ReadyState.new(self))
	self.add_state(GAME_STATE_TYPE.PLAYING, PlayingState.new(self))
	self.add_state(GAME_STATE_TYPE.PAUSE, PauseState.new(self))
	self.add_state(GAME_STATE_TYPE.END, EndState.new(self))





