extends Node2D

@export var enemy_scene : PackedScene
@export var spawn_locations : Array[Node2D] = []

signal enemy_has_spawned(enemy: Enemy)


func _ready() -> void:
	randomize()


func _on_spawner_timer_timeout() -> void:
	var index = randi_range(0, spawn_locations.size() - 1)
	var spawnLocation = spawn_locations[index]

	var enemy: Enemy = enemy_scene.instantiate()

	enemy.initialize(spawnLocation.global_position, spawnLocation.rotation)

	add_child(enemy)
	enemy_has_spawned.emit(enemy)
