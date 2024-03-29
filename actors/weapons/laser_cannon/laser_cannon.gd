extends Node2D

var laser_bolt_scene = preload("res://actors/weapons/red_laser_bolt.tscn")
var red_laser_sound_path := "res://assets/weapons/redlaser.wav"

var fire_delay = 0.1
var last_fire = 0

func create_laser_bolt():
	var laser = laser_bolt_scene.instantiate()
	laser.initialize(self.global_position + Vector2(0,-45).rotated(global_rotation), self.global_rotation, get_parent())
	get_parent().get_parent().add_child(laser)
	var player = get_tree().get_nodes_in_group("player")
	SoundManager.play_sound(red_laser_sound_path, self.global_position, player[0].global_position)

func _process(delta):
	if last_fire <= fire_delay:
		last_fire += delta

func fire_weapon():
	if last_fire > fire_delay:
		create_laser_bolt()
		last_fire = 0
