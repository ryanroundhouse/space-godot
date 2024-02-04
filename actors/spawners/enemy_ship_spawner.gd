extends Node2D

var enemy_ship_scene = preload("res://actors/ships/ship.tscn")
@export var number_of_enemy_ships := 2

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	#
	#for numberOfAsteroids in range(number_of_asteroids):
		#spawnRandomAsteroid()
		
	#var position = Vector2(-100,-300)
	#var linear_velocity = Vector2(0,90)
	#var angular_velocity = 0.0
	#var scale = 1.0
	#
	#var asteroid = asteroid_scene.instantiate() 
	#asteroid.initialize(position, linear_velocity, angular_velocity, scale)
	#add_child(asteroid)

func spawnRandomEnemyShip():
	var zone = find_parent("Zone")
	
	var ship_position = Vector2(randi_range(-zone.ZONE_WIDTH/2,zone.ZONE_WIDTH/2), randi_range(-zone.ZONE_HEIGHT/2,zone.ZONE_HEIGHT/2))
	
	var enemy_ship = enemy_ship_scene.instantiate() 
	enemy_ship.global_position = ship_position
	add_child(enemy_ship)
	print("spawned enemy ship at (" + str(ship_position.x) + "," + str(ship_position.y) + ")")


func _process(delta):
	
	if get_child_count() < number_of_enemy_ships:
		spawnRandomEnemyShip()
	
	if Input.is_key_pressed(KEY_P):
		spawnRandomEnemyShip()
