extends Node2D

var asteroid_scene = preload("res://actors/obstacles/asteroid.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var zone = find_parent("Zone")
	
	for numberOfAsteroids in range(40):
		# Create a random direction (angle)
		var directionX = (randf() * 2.0 - 1.0) * 300
		var directionY = (randf() * 2.0 - 1.0) * 300
		var rotationSpeed = randf_range(-3.0, 3.0)
		var scaleAmount = randi_range(1, 3)
		var scale = Vector2(scaleAmount, scaleAmount)
		
		var asteroid_position = Vector2(randi_range(-zone.ZONE_WIDTH,zone.ZONE_WIDTH), randi_range(-zone.ZONE_HEIGHT,zone.ZONE_HEIGHT))
		var direction = Vector2(directionX, directionY)
		
		var asteroid = asteroid_scene.instantiate() 
		asteroid.initialize(asteroid_position, direction, rotationSpeed, scale, numberOfAsteroids)
		add_child(asteroid)
		print("spawned asteroid  " + str(numberOfAsteroids) + " waat (" + str(asteroid.position.x) + "," + str(asteroid.position.y) + ") with direction (" + str(directionX) + "," + str(directionY) + ") and rotation speed: " + str(rotationSpeed))
	#debugAsteroid()
	
func debugAsteroid():
	var a_direction = Vector2(0,-100)
	var a_position = Vector2(-100,100)
	var asteroid = asteroid_scene.instantiate()
	asteroid.initialize(a_position, a_direction, 0, Vector2(1,1), 0)
	add_child(asteroid)
	var a_direction2 = Vector2(0,-100)
	var a_position2 = Vector2(-100,-100)
	var asteroid2 = asteroid_scene.instantiate()
	asteroid2.initialize(a_position2, -a_direction2, 0, Vector2(1,1), 1)
	add_child(asteroid2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
