extends Area2D

var pBulletEffect := preload("res://Bullet/EnemyBulletEffect.tscn")

export var speed: float = 200

func _physics_process(delta):
	position.y += speed * delta


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


func _on_Bullet_area_entered(area: Area2D) -> void:
	if area is Player:
		var bulletEffect  := pBulletEffect.instance()
		bulletEffect.position = position
		get_parent().add_child(bulletEffect)
		
		area.damage(1)
		queue_free()

