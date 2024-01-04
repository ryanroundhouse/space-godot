extends CharacterBody2D

@export var acceleration := 50.0
@export var max_speed := 850.0
@export var rotation_speed := 250.0

var fire_delay = 0.05
var last_fire = 0
var CAN_CONTROL := true

var docking_direction : Vector2

var laser_scene = preload("res://actors/weapons/red_laser.tscn")

func _process(delta):
	if Input.is_action_pressed("shoot") && last_fire > fire_delay:
		fire_laser()
		last_fire = 0
	else:
		last_fire += delta
	if World.IS_DEBUG:
		var label = get_node("Label") as Label
		label.rotation = -rotation
		label.text = "Pos: %s" % position

func fire_laser():
	var laser = laser_scene.instantiate()
	laser.initialize(self.position + Vector2(0,-25).rotated(rotation), self.rotation)
	get_parent().add_child(laser)

func _physics_process(delta):
	if CAN_CONTROL:
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
		
		
		for collisionIndex in get_slide_collision_count():
			var collisionSubject = get_slide_collision(collisionIndex)
			#if collisionSubject.get_collider() is RigidBody2D:
			velocity += collisionSubject.get_normal() * 1000
		
		# slow down if not moving faster
		if input_vector.y == 0:
			velocity = velocity.move_toward(Vector2.ZERO, 8)

	# move
	move_and_slide()
	
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

func launchFromDock(launch_position: Vector2, launch_direction: float, launch_velocity: Vector2):
	CAN_CONTROL = true
	position = launch_position
	rotation = launch_direction
	velocity += launch_velocity


func dockTowards(direction: Vector2):
	velocity = Vector2(0,0)
	#rotation = direction.angle()
	docking_direction = direction
	print("docking towards: " + str(direction))
	
	var stall_timer = Timer.new()
	stall_timer.wait_time = 2
	stall_timer.one_shot = true
	add_child(stall_timer)
	stall_timer.connect("timeout", startDocking)
	stall_timer.start()
	
	CAN_CONTROL = false

func startDocking():
	print("start docking")
	collision_mask = 0
	velocity += docking_direction * 100
	
	var dock_timer = Timer.new()
	dock_timer.wait_time = 2
	dock_timer.one_shot = true
	add_child(dock_timer)
	dock_timer.connect("timeout", finishDocking)
	dock_timer.start()

func finishDocking():
	print("finished docking")
	velocity = Vector2(0,0)
	get_tree().change_scene_to_packed(World.menu_scene)
	
