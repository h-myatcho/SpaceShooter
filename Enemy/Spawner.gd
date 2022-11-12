extends Node2D

const MIN_SPAWN_TIME = 1.5

var preloadedEnemies := [
	preload("res://Enemy/BounceEnemy.tscn"),
	preload("res://Enemy/FastEnemy.tscn"),
	preload("res://Enemy/SlowEnemy.tscn"),
	preload("res://Enemy/SlowShooter.tscn"),
	preload("res://Enemy/BounceShooter.tscn")
]

var plMeteor := preload("res://Meteor/Meteor.tscn")

onready var spawnTimer := $SpawnTimer

var nextSpawnTimer := 5

func _ready():
	randomize()
	spawnTimer.start(nextSpawnTimer)


func _on_SpawnTimer_timeout() -> void:
	# Spawn an enemy
	var viewRect := get_viewport_rect()
	var xPos := rand_range(viewRect.position.x, viewRect.end.x)
	# meteor
	if randi() < 0.8:
		var meteor: = plMeteor.instance()
		meteor.position = Vector2(xPos, position.y)
		get_tree().current_scene.add_child(meteor)
	else:
		var enemyPreload = preloadedEnemies[randi() % preloadedEnemies.size()]
		var enemy: Enemy = enemyPreload.instance()
		enemy.position = Vector2(xPos, position.y)
		get_tree().current_scene.add_child(enemy)
	
	# Restart the timer
	nextSpawnTimer -= 0.1
	if nextSpawnTimer < MIN_SPAWN_TIME:
		nextSpawnTimer = MIN_SPAWN_TIME
	spawnTimer.start(nextSpawnTimer)
