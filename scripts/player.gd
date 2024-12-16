extends CharacterBody2D

@export var limitX: Vector2 # x: min, y: max
@export var limitY: Vector2 # x: min, y: max

const SCALE_FACTOR = 100


func _process(_delta: float) -> void:
	var direction: Vector2 = Vector2.ZERO

	if Input.is_action_just_pressed("move_left") and position.x > limitX.x:
		direction = Vector2.LEFT
	elif Input.is_action_just_pressed("move_right") and position.x < limitX.y:
		direction = Vector2.RIGHT
	elif Input.is_action_just_pressed("move_up") and position.y > limitY.x:
		direction = Vector2.UP
	elif Input.is_action_just_pressed("move_down") and position.y < limitY.y:
		direction = Vector2.DOWN

	if direction != Vector2.ZERO:
		translate(direction * SCALE_FACTOR)
