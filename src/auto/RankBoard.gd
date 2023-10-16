extends Node

## 这个脚本负责维护排行榜

@export var config_path : String = "user://rank_board.cfg"

var rank_board = [
	{'name':'', 'score': 0},
	{'name':'', 'score': 0},
	{'name':'', 'score': 0},
]
var config = ConfigFile.new()

## 读取排行榜
func load_rank_board() -> void:
	var err = config.load(config_path)
	if err == OK:
		for i in range(3):
			var player_data = config.get_value('Player' + str(i + 1), 'data', {'name':'', 'score': 0})
			rank_board[i] = player_data

## 保存排行榜
func save_rank_board() -> void:
	for i in range(0, 3):
		config.set_value('Player' + str(i + 1), 'data', rank_board[i])
	config.save(config_path)


## 检查排行榜是否需要更新
func check_rank_board(new_score: int) -> bool:
	for i in range(rank_board.size()):
		if new_score > rank_board[i].score:
			return true
	return false

## 更新排行榜
func update_rank_board(new_name: String, new_score: int) -> void:
	rank_board.append({'name': new_name, 'score': new_score})
	rank_board.sort_custom(
		func(a, b): # 匿名函数
			return a.score > b.score
	)
	rank_board.pop_back()
	save_rank_board()
