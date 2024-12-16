extends RigidBody2D
class_name Enemy

@export var min_speed: int = 650
@export var max_speed: int = 650
var speed = 0

@onready var sprite: Sprite2D = $Sprite2D
@onready var sound: AudioStreamPlayer2D = $DeathSound

signal has_hit_player


func _ready() -> void:
	speed = randi_range(min_speed, max_speed)
	if rotation > PI / 2 and rotation < ((3 * PI) / 2):
		sprite.flip_v = true


func initialize(position_desired: Vector2, rotation_desired: float):
	position = position_desired
	rotation = rotation_desired


func _physics_process(delta: float) -> void:
	var _temp = global_position.x # DONT DELETE THIS ELSE POSITIONS OF ALL ENEMIES RESET AT EACH SPAWN
	translate(transform.x * speed * delta)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(_body: Node) -> void:
	sound.play()
	Engine.time_scale = 0


func _on_death_sound_finished() -> void:
	has_hit_player.emit()
	Engine.time_scale = 1
