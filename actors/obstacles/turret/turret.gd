extends Node2D

enum state { IDLE, TRACKING }

signal blowUp()

var targets = []
var mode := state.IDLE
var rotation_speed = 36

@export var death_particle_scene = preload("res://actors/players/player_explosion.tscn")
@export var primaryWeaponScene := preload("res://actors/weapons/laser_cannon/laser_cannon.tscn")
var asteroid_break_sound_path := "res://assets/obstacles/asteroid_break.wav"

var primaryWeapon : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	find_child("primaryBody").connect("blowUp", onBlowUp)
	primaryWeapon = primaryWeaponScene.instantiate()
	primaryWeapon.rotation = deg_to_rad(90)
	add_child(primaryWeapon)

func onBlowUp():
	SoundManager.play_sound(asteroid_break_sound_path)
	for child in find_child("DuplicateOnEdges").get_children():
		var death_particle = death_particle_scene.instantiate()
		death_particle.position = child.global_position
		death_particle.emitting = true
		get_tree().current_scene.add_child(death_particle)
	blowUp.emit()
	queue_free()

func fire_weapon():
	if primaryWeapon:
		primaryWeapon.fire_weapon()

func damage(damage_amount):
	print("I should blow up")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if targets.size() > 0:
		mode = state.TRACKING
	else:
		mode = state.IDLE
		
	if mode == state.IDLE:
		process_idle(delta)
	elif mode == state.TRACKING:
		process_tracking(delta)
	else:
		print(name + " has unknown state")

func process_tracking(delta):
	var target_angle = (targets[0].global_position - global_position).angle()
	var current_angle = rotation
	
	var difference = shortest_angle_between(target_angle, current_angle)
	if difference > -1 && difference < 1:
		fire_weapon()
	
	var rotation_amount = rotation_speed * delta
	rotation_amount = min(rotation_amount, abs(difference))

	if difference < 0:
		rotation_amount = -rotation_amount

	rotation += deg_to_rad(rotation_amount)

func shortest_angle_between(target, current):
	var difference = fmod(target - current, TAU)
	if difference > PI:
		difference -= TAU
	elif difference < -PI:
		difference += TAU
	return difference

func process_idle(delta):
	rotation_degrees += rotation_speed * delta
	rotation = deg_to_rad(rotation_degrees)

func _on_sensor_body_entered(body):
	#print(body.name + " body entered sensor range")
	if not targets.has(body):
		targets.append(body)


func _on_sensor_body_exited(body):
	#print(body.name + " body exited sensor range")
	if targets.has(body):
		targets.erase(body)
