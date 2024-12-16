extends Node2D

var score: int = 0
@export var score_win = 100
var highscore: int = 0

var picked_coins: int = 0
var number_coins: int = 0

signal score_changed(score: int)
signal highscore_changed(highscore: int)
signal all_coins_picked()
signal coin_picked(new_coins: int)
signal coins_initialized(number_coins: int)


func _ready() -> void:
	Storage.load()

#region Score Initialization
	score = Storage.read_value("score")

	if score < 0:
		score = 0

	score_changed.emit(score)

	score_changed.connect(save_score)
#endregion

#region Highscore Initialization
	highscore = Storage.read_value("highscore")
	if highscore < 0:
		highscore = 0
		save_highscore()

	highscore_changed.emit(highscore)

	score_changed.connect(check_highscore)
#endregion

#region Coins Init
	var coins: Array = get_tree().get_nodes_in_group("coins")
	for coin in coins:
		coin.coin_picked.connect(pick_coin)
	number_coins = coins.size()
	coins_initialized.emit(number_coins)
#endregion


func pick_coin(value: int):
	picked_coins += 1
	coin_picked.emit(picked_coins)
	if picked_coins == number_coins:
		all_coins_picked.emit()
	add_score(value)


func add_score(value: int):
	score += value
	score_changed.emit(score)


func reset_score():
	score = 0
	score_changed.emit(0)


func _on_goal_reached() -> void:
	add_score(score_win)
	call_deferred("restart_scene")


func check_highscore(new_score: int):
	if new_score > highscore:
		highscore = new_score
		highscore_changed.emit(highscore)
		save_highscore()


func restart_scene():
	get_tree().reload_current_scene()


func save_score(new_score: int):
	Storage.save_value("score", new_score)


func save_highscore():
	Storage.save_value("highscore", highscore)


func _on_spawner_enemy_has_spawned(enemy: Enemy) -> void:
	enemy.has_hit_player.connect(_on_enemy_has_hit_player)


func _on_enemy_has_hit_player():
	reset_score()
	call_deferred("restart_scene")

# when game exists
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		# reset score so that, when the game starts again, the player starts whith a score of 0
		save_score(0)
		# maybe leave the score at its current value and instead keep track of which coins have been picked up
		# so that only coins that have not been picked up will spawn
