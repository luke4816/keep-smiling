extends Area2D
class_name Coin

@export var score: int = 10
@onready var animation_player = $AnimationPlayer

signal coin_picked(score: int)

func _on_body_entered(_body: Node2D) -> void:
	coin_picked.emit(score)
	animation_player.play("pickup")
