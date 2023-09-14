extends Node2D

@export var speed = 100
signal rock_hit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position.x -= speed * delta
	if self.position.x <= -100:
		self.queue_free()

func _on_hurt_area_area_entered(area: Area2D) -> void:
	rock_hit.emit()
