extends Area2D
class_name Enemy

var plBullet := preload("res://Bullet/EnemyBullet.tscn")
# fire
onready var firingPosition := $FiringPosition

var plEnemyExplosion := preload("res://Enemy/EnemyExplosion.tscn")

export var verticalSpeed := 50.0
export var health: int = 5

var playerInArea: Player = null

func _process(delta):
	if playerInArea != null:
		playerInArea.damage(1)

func _physics_process(delta):
	position.y += verticalSpeed * delta
	
# fire 
func  fire():
	for child in firingPosition.get_children():
		var bullet := plBullet.instance()
		bullet.global_position = child.global_position
		get_tree().current_scene.add_child(bullet)
	
func damage(amount: int):
	if health <= 0:
		return
	
	health -= amount
	if health <= 0:
		var effect := plEnemyExplosion.instance()
		effect.global_position = global_position
		get_tree().current_scene.add_child(effect)
		
		Signals.emit_signal("on_score_increment", 1)
		
		queue_free()

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


func _on_Enemy_area_entered(area: Area2D) -> void:
	if area is Player:
		playerInArea = area


func _on_Enemy_area_exited(area: Area2D) -> void:
	if area is Player:
		playerInArea = null
