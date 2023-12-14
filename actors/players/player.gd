extends CharacterBody2D

@export var acceleration := 50.0
@export var max_speed := 850.0
@export var rotation_speed := 250.0

var ZONE_WIDTH := 5120
var ZONE_HEIGHT := 5120

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

	# slow down if not moving faster
	if input_vector.y == 0:
		velocity = velocity.move_toward(Vector2.ZERO, 8)

	# wrap player to opposite side of zone
	if position.x > ZONE_WIDTH / 2:
		position.x = -ZONE_WIDTH / 2
	elif position.x < -ZONE_WIDTH / 2:
		position.x = ZONE_WIDTH / 2
	if position.y > ZONE_HEIGHT / 2:
		position.y = -ZONE_HEIGHT / 2
	elif position.y < -ZONE_HEIGHT / 2:
		position.y = ZONE_HEIGHT / 2
