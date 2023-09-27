extends CharacterBody2D


const SPEED = 200.0

signal rock_entered

func _physics_process(delta: float) -> void:
	self.velocity.x = SPEED * -1
	move_and_slide()
	if self.position.x <= -56:
		self.queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
#	print("撞击了！")
	rock_entered.emit()
