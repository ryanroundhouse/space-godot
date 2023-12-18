extends Node2D

var asteroid_scene = preload("res://actors/obstacles/asteroid.tscn")
@export var number_of_asteroids := 35

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	#
	#for numberOfAsteroids in range(number_of_asteroids):
		#spawnRandomAsteroid()
		
	var position = Vector2(50,-300)
	var linear_velocity = Vector2(0,-30)
	var angular_velocity = 0.0
	var scale = 1.0
	
	var asteroid = asteroid_scene.instantiate() 
	asteroid.initialize(position, linear_velocity, angular_velocity, scale)
	add_child(asteroid)

func spawnRandomAsteroid():
	var zone = find_parent("Zone")
	var directionX = (randf() * 2.0 - 1.0) * 250
	var directionY = (randf() * 2.0 - 1.0) * 250
	var angular_velocity = randf_range(-3.0, 3.0)
	var scaleAmount = randi_range(1, 3)
	#var scale = Vector2(scaleAmount, scaleAmount)
	
	var asteroid_position = Vector2(randi_range(-zone.ZONE_WIDTH,zone.ZONE_WIDTH), randi_range(-zone.ZONE_HEIGHT,zone.ZONE_HEIGHT))
	var linear_velocity = Vector2(directionX, directionY)
	
	var asteroid = asteroid_scene.instantiate() 
	asteroid.initialize(asteroid_position, linear_velocity, angular_velocity, scaleAmount)
	add_child(asteroid)
	print("spawned asteroid at (" + str(asteroid.position.x) + "," + str(asteroid.position.y) + ") with linear_velocity (" + str(directionX) + "," + str(directionY) + ") and angular_velocity: " + str(angular_velocity))


func _process(delta):
	
	if get_child_count() < number_of_asteroids:
		spawnRandomAsteroid()
	
	if Input.is_key_pressed(KEY_P):
		spawnRandomAsteroid()
