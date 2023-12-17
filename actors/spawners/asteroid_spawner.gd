extends Node2D

var asteroid_scene = preload("res://actors/obstacles/asteroid.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var zone = find_parent("Zone")
	
	for numberOfAsteroids in range(130):
		# Create a random direction (angle)
		var directionX = (randf() * 2.0 - 1.0) * 300
		var directionY = (randf() * 2.0 - 1.0) * 300
		var rotationSpeed = randf_range(-3.0, 3.0)
		var scaleAmount = randi_range(1, 3)
		var scale = Vector2(scaleAmount, scaleAmount)
		
		var asteroid_position = Vector2(randi_range(-zone.ZONE_WIDTH,zone.ZONE_WIDTH), randi_range(-zone.ZONE_HEIGHT,zone.ZONE_HEIGHT))
		var direction = Vector2(directionX, directionY)
		
		var asteroid = asteroid_scene.instantiate() 
		asteroid.initialize(asteroid_position, direction, rotationSpeed, scale)
		add_child(asteroid)
		print("spawned asteroid at (" + str(asteroid.position.x) + "," + str(asteroid.position.y) + ") with direction (" + str(directionX) + "," + str(directionY) + ") and rotation speed: " + str(rotationSpeed))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
