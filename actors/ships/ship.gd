extends CharacterBody2D

enum state { APPROACHING, RETREATING, IDLE }

@export var acceleration := 300.0
@export var max_speed := 550.0
@export var rotation_speed := 2.0

@export var primaryWeaponScene := preload("res://actors/weapons/laser_cannon/laser_cannon.tscn")
var primaryWeapon : Node2D

var mode = state.APPROACHING
var min_combat_distance := 200
var max_combat_distance := 800
var detection_distance := 1200

var target: Node2D

func _ready():
	primaryWeapon = primaryWeaponScene.instantiate()
	primaryWeapon.rotation = deg_to_rad(90)
	add_child(primaryWeapon)

func _physics_process(delta):
	if target:
		if mode == state.APPROACHING:
			var direction = (target.global_position - global_position).normalized()
			var target_rotation = atan2(direction.y, direction.x)
			
			rotation = lerp_angle(rotation, target_rotation, rotation_speed * delta)
			
			velocity = Vector2(cos(rotation), sin(rotation)) * acceleration
			velocity = velocity.limit_length((max_speed))
			move_and_slide()
		elif mode == state.RETREATING:
			var direction = -(target.global_position - global_position).normalized()
			var target_rotation = atan2(direction.y, direction.x)
			
			rotation = lerp_angle(rotation, target_rotation, rotation_speed * delta)
			
			velocity = Vector2(cos(rotation), sin(rotation)) * acceleration
			velocity = velocity.limit_length((max_speed))
			move_and_slide()
		
		# change state
		var distance = target.global_position.distance_to(global_position)
		if distance < min_combat_distance:
			mode = state.RETREATING
		elif distance > detection_distance:
			mode = state.IDLE
		elif mode == state.RETREATING and distance > max_combat_distance:
			mode = state.APPROACHING
		elif mode == state.IDLE and distance < max_combat_distance:
			mode = state.APPROACHING
		
		# fire weapon
		var target_angle = (target.global_position - global_position).angle()
		var current_angle = rotation
		var difference = shortest_angle_between(target_angle, current_angle)
		if difference > -1 && difference < 1:
			fire_weapon()
	else:
		var targets = get_tree().get_nodes_in_group("Player")
		if targets:
			target = targets[0]

func fire_weapon():
	if primaryWeapon:
		primaryWeapon.fire_weapon()

func shortest_angle_between(target, current):
	var difference = fmod(target - current, TAU)
	if difference > PI:
		difference -= TAU
	elif difference < -PI:
		difference += TAU
	return difference
