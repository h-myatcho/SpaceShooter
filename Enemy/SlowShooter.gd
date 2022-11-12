extends Enemy
class_name SlowShooter

onready var fireTimer := $FireTimer

export var fireRate := 5

func _process(delta):
	if fireTimer.is_stopped():
		fire()
		fireTimer.start((fireRate))
