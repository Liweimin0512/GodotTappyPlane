extends Control
class_name UIBase

"""
是所有具体UI界面（如UIForm, UIPopup）的基类。
包含对当前UIManager的持有，提供UI的name方便查找
包含开启和关闭UI界面时的回调函数
"""

var interface_name : StringName = ""
var ui_manager: UIManager :
	get:
		return get_parent()

## 界面开启时调用
func _opened(data: Dictionary = {}) -> void:
	pass

## 界面关闭时调用
func _closed() -> void:
	pass
