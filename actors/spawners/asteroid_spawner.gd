extends Node2D

var asteroid_scene: PackedScene = load("res://actors/obstacles/asteroid.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	var asteroid = asteroid_scene.instantiate()
	asteroid.position.x = 100
	asteroid.position.y = 100
	
	# Define the maximum speed
	var speed = 100
	# Create a random direction (angle)
	var direction = Vector2(randf() * 2.0 - 1.0, randf() * 2.0 - 1.0).normalized()

	add_child(asteroid)
	print("spawned asteroid at (" + str(asteroid.position.x) + "," + str(asteroid.position.y) + ")")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
