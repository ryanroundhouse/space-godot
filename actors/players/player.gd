extends CharacterBody2D

@export var acceleration := 50.0
@export var max_speed := 850.0
@export var rotation_speed := 250.0

func _physics_process(delta):
	# determine acceleration
	var input_vector := Vector2(0, Input.get_axis("accelerate", "descelerate"))
	
	# move player
	velocity += input_vector.rotated(rotation) * acceleration
	velocity = velocity.limit_length((max_speed))
	
	# rotate ship
	if Input.is_action_pressed("rotate_right"):
		rotate(deg_to_rad(rotation_speed * delta))
	if Input.is_action_pressed("rotate_left"):
		rotate(deg_to_rad(-rotation_speed * delta))
	
	# move
	move_and_slide()
	
	for collisionIndex in get_slide_collision_count():
		var collisionSubject = get_slide_collision(collisionIndex)
		if collisionSubject.get_collider() is RigidBody2D:
			collisionSubject.get_collider().apply_central_impulse(-collisionSubject.get_normal() * 10)
			velocity += collisionSubject.get_normal() * 10
			print("blasting")

	# slow down if not moving faster
	if input_vector.y == 0:
		velocity = velocity.move_toward(Vector2.ZERO, 8)

	# wrap player to opposite side of zone
	var zone = find_parent("Zone")
	if position.x > zone.ZONE_WIDTH / 2:
		position.x = -zone.ZONE_WIDTH / 2
	elif position.x < -zone.ZONE_WIDTH / 2:
		position.x = zone.ZONE_WIDTH / 2
	if position.y > zone.ZONE_HEIGHT / 2:
		position.y = -zone.ZONE_HEIGHT / 2
	elif position.y < -zone.ZONE_HEIGHT / 2:
		position.y = zone.ZONE_HEIGHT / 2
