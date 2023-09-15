extends Node

var leaderboard = [{"name": "", "score": 0}, {"name": "", "score": 0}, {"name": "", "score": 0}]
var config = ConfigFile.new()

## 读取排行榜
func load_leaderboard():
	var err = config.load("user://leaderboard.cfg")
	if err == OK:
		for i in range(3):
			var player_data = config.get_value("Player" + str(i + 1), "data", {"name": "", "score": 0})
			leaderboard[i] = player_data

## 保存排行榜
func save_leaderboard():
	for i in range(3):
		config.set_value("Player" + str(i + 1), "data", leaderboard[i])
	config.save("user://leaderboard.cfg")

## 检查排行榜是否需要更新
func check_leaderboard(new_score: int) -> bool:
	for i in range(leaderboard.size()):
		if new_score > leaderboard[i].score:
			return true
	return false

## 更新排行榜
func update_leaderboard(new_name: String, new_score: int) -> void:
	leaderboard.append({"name": new_name, "score": new_score})
	leaderboard.sort_custom(func(a, b): return a.score > b.score)
	leaderboard.pop_back()
	save_leaderboard()
