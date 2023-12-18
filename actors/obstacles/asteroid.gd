extends Node2D

var asteroid_scale : float = 1.0

func initialize(position: Vector2, linear_velocity: Vector2, angular_velocity: float, scale: float):
	var primaryBody = find_child("primaryBody")
	primaryBody.position = position
	primaryBody.linear_velocity = linear_velocity
	primaryBody.angular_velocity = angular_velocity
	primaryBody.isPrimary = true
	
	asteroid_scale = scale
	
	var mainSprite = find_child("MainSprite")
	mainSprite.scale *= scale;
	var collision = find_child("AsteroidCollisionShape")
	collision.scale *= scale;

func _process(delta):
	var primaryBody = find_child("primaryBody")
	
	for child in find_child("DuplicateOnEdges").get_children():
		if child.name != "primaryBody":
			child.position = primaryBody.position + child.asteroid_offset
			child.rotation += primaryBody.angular_velocity * delta
			#print("setting " + child.name + " to (" + str(child.position.x) + "," + str(child.position.y) + ")")
