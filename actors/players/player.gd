extends CharacterBody2D

@export var acceleration := 50.0
@export var max_speed := 850.0
@export var rotation_speed := 250.0

@export var primaryWeaponScene := preload("res://actors/weapons/laser_cannon/laser_cannon.tscn")
var primaryWeapon : Node2D

var damage_delay = 0.1
var last_damage = 0

var CAN_CONTROL := true
var health : = 100.0
var max_health := 100.0

var docking_direction : Vector2

var destination_system : String = ""
var jump_timer : Timer

var collision_path = "res://assets/ships/collision.wav"

var death_particle_scene = preload("res://actors/players/player_explosion.tscn")
var asteroid_break_sound_path := "res://assets/obstacles/asteroid_break.wav"

func _ready():
	jump_timer = Timer.new()
	jump_timer.wait_time = 3
	add_child(jump_timer)
	jump_timer.connect("timeout", _on_jump_timer_timeout)
	
	primaryWeapon = primaryWeaponScene.instantiate()
	add_child(primaryWeapon)
	update_health_bar()

func _on_jump_timer_timeout():
	if destination_system:
		get_tree().change_scene_to_packed(World.menu_scene)
	else:
		print("jump aborted!")

func _process(delta):
	if CAN_CONTROL:
		if Input.is_action_pressed("shoot"):
			fire_weapon()
		if Input.is_action_just_pressed("initiate_jump"):
			jump_timer.start()
		if Input.is_action_just_released("initiate_jump"):
			jump_timer.stop()
			
		if last_damage < damage_delay:
			last_damage += delta
	
	if World.IS_DEBUG:
		var label = get_node("Label") as Label
		label.rotation = -rotation
		label.text = "Pos: %s" % position

func damage(amount):
	if last_damage >= damage_delay:
		health -= amount
		health = max(health, 0)
		update_health_bar()
		if !health:
			destroy_player()
		last_damage = 0

func destroy_player():
	onBlowUp()

func get_closest_body_dupe_position(target_position: Vector2) -> Vector2:
	var closest_position: Vector2 = Vector2.ZERO
	var min_distance: float = INF  # Initialize with infinity

	for body in find_child("DuplicateOnEdges").get_children():
		if body.is_in_group("BodyDupe"):
			var distance = target_position.distance_to(body.global_position)
			if distance < min_distance:
				min_distance = distance
				closest_position = body.global_position

	return closest_position

func set_jump_destination(destination):
	destination_system = destination
	print("destination set to: " + destination_system)

func remove_jump_destination():
	destination_system = ""
	print("destination set to: " + destination_system)

func update_health_bar():
	$health_bar.set_health(health / max_health * 100.0)

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
			var player = get_tree().get_nodes_in_group("player")
			SoundManager.play_sound(collision_path, global_position, player[0].global_position)
			var collisionSubject = get_slide_collision(collisionIndex)
			#if collisionSubject.get_collider() is RigidBody2D:
			velocity += collisionSubject.get_normal() * 1000
			damage(25)
		
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

func fire_weapon():
	if primaryWeapon:
		primaryWeapon.fire_weapon()

func onBlowUp():
	SoundManager.play_sound(asteroid_break_sound_path, global_position, global_position)
	var death_particle = death_particle_scene.instantiate()
	death_particle.position = global_position
	death_particle.emitting = true
	get_tree().current_scene.add_child(death_particle)
	CAN_CONTROL = false
	velocity = Vector2.ZERO
	visible = false
	
	var restart_timer = Timer.new()
	restart_timer.wait_time = 5
	restart_timer.one_shot = true
	add_child(restart_timer)
	restart_timer.connect("timeout", restart)
	restart_timer.start()

func restart():
	get_tree().change_scene_to_packed(World.menu_scene)	 

func launchFromDock(launch_position: Vector2, launch_direction: float, launch_velocity: Vector2):
	CAN_CONTROL = true
	global_position = launch_position
	#rotation = launch_direction
	rotation_degrees = launch_direction
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
	velocity = Vector2.ZERO
	get_tree().change_scene_to_packed(World.menu_scene)
	
