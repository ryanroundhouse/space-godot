extends Node2D

var asteroid_scene = preload("res://actors/obstacles/asteroid.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var world = find_parent("World")
	
	for numberOfAsteroids in range(30):
		# Create a random direction (angle)
		var directionX = (randf() * 2.0 - 1.0) * 300
		var directionY = (randf() * 2.0 - 1.0) * 300
		
		var asteroid_position = Vector2(randi_range(-world.ZONE_WIDTH,world.ZONE_WIDTH), randi_range(-world.ZONE_HEIGHT,world.ZONE_HEIGHT))
		var direction = Vector2(directionX, directionY)
		
		var asteroid = asteroid_scene.instantiate() 
		asteroid.initialize(asteroid_position, direction)
		add_child(asteroid)
		print("spawned asteroid at (" + str(asteroid.position.x) + "," + str(asteroid.position.y) + ") with direction (" + str(directionX) + "," + str(directionY) + ") and rotation: " + str(rotation))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
