extends Area2D

signal goal_reached

var can_finish = false
@export var color_block_finish: Color = Color("#ff0036")
@export var color_can_finish: Color = Color("#00ff59")

@onready var sprite: Sprite2D = $GFX
@onready var sound: AudioStreamPlayer2D = $FinishSound

func _ready() -> void:
	change_color(color_block_finish)

func change_color(color: Color):
	sprite.modulate = color


func _on_body_entered(_body: Node2D) -> void:
	if can_finish:
		sound.play()


func _on_game_manager_all_coins_picked() -> void:
	can_finish = true
	change_color(color_can_finish)


func _on_finish_sound_finished() -> void:
	goal_reached.emit()
