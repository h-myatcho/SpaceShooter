extends Enemy

export var rotationRate := 20

# rotate
func _process(delta):
	
	rotate(deg2rad(rotationRate) * delta)


