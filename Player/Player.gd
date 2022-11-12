extends Area2D
class_name Player
var plBullet := preload("res://Bullet/Bullet.tscn")


onready var animatedSprite := $AnimatedSprite
onready var firingPosition := $FiringPosition
onready var fireDelayTimer := $FireDelayTimer
onready var invinciblityTimer := $InvincibilityTimer
onready var shieldSprite := $Shield

export var speed: float = 300
export var fireDelay: float = 0.1
export var life: int = 3
export var damageInvincibilityTime := 2
var vel := Vector2(0,0)

func _ready():
	shieldSprite.visible = false
	Signals.emit_signal("on_player_life_changed", life)

func _process(delta): # animate
	if vel.x < 0:
		animatedSprite.play("Left")
	elif vel.x > 0:
		animatedSprite.play("Right")
	else:
		animatedSprite.play("Straight")
		
	# check shooting
	if Input.is_action_pressed("shoot") and fireDelayTimer.is_stopped():
		fireDelayTimer.start(fireDelay)
		for child in firingPosition.get_children():
			var bullet := plBullet.instance()
			bullet.global_position = child.global_position
			get_tree().current_scene.add_child(bullet)

func _physics_process(delta):
	var dirVec := Vector2(0,0)
	
	if Input.is_action_pressed("move_left"):
		dirVec.x = -1
	elif Input.is_action_pressed("move_right"):
		dirVec.x = 1
	if Input.is_action_pressed("move_up"):
		dirVec.y = -1
	elif Input.is_action_pressed("move_down"):
		dirVec.y = 1
	
	vel = dirVec.normalized() * speed
	position += vel * delta
	
	# viewport
	var viewRect := get_viewport_rect()
	position.x = clamp(position.x, 0, viewRect.size.x)
	position.y = clamp(position.y, 0, viewRect.size.y)
	
# damage
func damage(amount: int):
	if !invinciblityTimer.is_stopped():
		return
		
	invinciblityTimer.start(damageInvincibilityTime)
	shieldSprite.visible = true
	
	life -= amount
	Signals.emit_signal("on_player_life_changed", life)
	
	var cam := get_tree().current_scene.find_node("Cam", true, false)
	cam.shake(20)
	
	if life <= 0:
		queue_free()
		get_tree().change_scene("res://GO.tscn")
		
# shield time out
func _on_InvincibilityTimer_timeout() -> void:
	shieldSprite.visible = false
