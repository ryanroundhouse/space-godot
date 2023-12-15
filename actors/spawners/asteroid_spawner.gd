extends Node2D

var asteroid_scene: PackedScene = load("res://actors/obstacles/asteroid.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	var asteroid = asteroid_scene.instantiate()
	asteroid.position.x = 100
	asteroid.position.y = -2300
	
	# Create a random direction (angle)
	var directionX = (randf() * 2.0 - 1.0) * 300
	var directionY = (randf() * 2.0 - 1.0) * 300
	#var directionX = -500
	#var directionY = 0
	var rotation = (randf() * 2.0 - 1.0) * 10
	asteroid.linear_velocity = Vector2(directionX, directionY);
	asteroid.angular_velocity = rotation;

	add_child(asteroid)
	print("spawned asteroid at (" + str(asteroid.position.x) + "," + str(asteroid.position.y) + ") with direction (" + str(directionX) + "," + str(directionY) + ") and rotation: " + str(rotation))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
