extends Area2D

var pBulletEffect := preload("res://Bullet/BulletEffect.tscn")

export var speed: float = 500

func _physics_process(delta):
	position.y -= speed * delta


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


func _on_Bullet_area_entered(area: Area2D) -> void:
	if area.is_in_group("damageable"):
		var bulletEffect  := pBulletEffect.instance()
		bulletEffect.position = position
		get_parent().add_child(bulletEffect)
		
		#cam shake
		var cam := get_tree().current_scene.find_node("Cam", true, false)
		cam.shake(1)
		
		area.damage(1)
		queue_free()
