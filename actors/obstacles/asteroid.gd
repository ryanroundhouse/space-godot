extends Node2D

var asteroid_scale : float = 1.0
var death_particle_scene = preload("res://actors/obstacles/asteroid_explosion.tscn")

func _ready():
	find_child("primaryBody").connect("blowUp", onBlowUp)

func onBlowUp(explosion_position):
	var death_particle = death_particle_scene.instantiate()
	death_particle.position = explosion_position
	death_particle.emitting = true
	get_tree().current_scene.add_child(death_particle)
	
	queue_free()

func initialize(initial_position: Vector2, linear_velocity: Vector2, angular_velocity: float, initial_scale: float):
	var primaryBody = find_child("primaryBody")
	primaryBody.position = initial_position
	primaryBody.linear_velocity = linear_velocity
	primaryBody.angular_velocity = angular_velocity
	primaryBody.isPrimary = true
	
	asteroid_scale = initial_scale
	
	var mainSprite = find_child("MainSprite")
	mainSprite.scale *= initial_scale;
	var collision = find_child("CollisionShape")
	collision.scale *= initial_scale;

func _process(delta):
	var primaryBody = find_child("primaryBody")
	
	for child in find_child("DuplicateOnEdges").get_children():
		if child.name != "primaryBody":
			child.position = primaryBody.position + child.duplicate_offset
			child.rotation += primaryBody.angular_velocity * delta
			#print("setting " + child.name + " to (" + str(child.position.x) + "," + str(child.position.y) + ")")
