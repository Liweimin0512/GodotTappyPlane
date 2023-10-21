extends UIForm
class_name GameForm

## 这个HBoxContainer可以让我们的子节点（TextureRect节点水平分布）
@onready var score_container: HBoxContainer = %ScoreContainer

## 数字图片对应的数组，通过索引可以获取对应的数字图片，比如索引5对应的恰好就是number5.png
var number_textures = [
	preload("res://assets/textures/widgets/numbers/number0.png"), 
	preload("res://assets/textures/widgets/numbers/number1.png"), 
	preload("res://assets/textures/widgets/numbers/number2.png"), 
	preload("res://assets/textures/widgets/numbers/number3.png"), 
	preload("res://assets/textures/widgets/numbers/number4.png"), 
	preload("res://assets/textures/widgets/numbers/number5.png"), 
	preload("res://assets/textures/widgets/numbers/number6.png"), 
	preload("res://assets/textures/widgets/numbers/number7.png"), 
	preload("res://assets/textures/widgets/numbers/number8.png"), 
	preload("res://assets/textures/widgets/numbers/number9.png")
]

## 更新分数显示 
func update_score_display(current_score: int) -> void:
	# 先把分数转换成字符串，这样可以获得位数，比如20就是"20"
	var score_str : String = str(current_score) 
	# 通过字符串的length知道当前分数是几位数, 20就是2位数
	var digit_count = score_str.length()
	# 对当前的分数，按位数进行遍历
	for i in range(digit_count):
		# digit 将当前位数转换为数值，2或者0
		var digit = int(score_str[i])
		# 根据当前数值创建TextureRect并赋值
		var digit_sprite : TextureRect
		# 因为我们的分数是随着游戏增加的，理论上位数也在发生变化，这时候就需要动态的添加新的TextureRect节点。
		# 比如，99需要2个TextureRect节点，而100则需要3个，这时候就需要添加1个新的TextureRect用来显示百位
		if score_container.get_child_count() <= i:
			digit_sprite = TextureRect.new()
			score_container.add_child(digit_sprite)
		else:
			digit_sprite = score_container.get_child(i)
		# 通过索引找到对应的图片，并赋值给TextureRect节点的Texture属性，完成图片显示
		digit_sprite.texture = number_textures[digit]
