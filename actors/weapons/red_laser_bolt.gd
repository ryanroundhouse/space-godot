extends Node2D

var red_laser_sound_path := "res://assets/weapons/redlaser.wav"
var damage := 10
var source : Node2D

func _ready():
	find_child("primaryBody").connect("destroy_laser", onDestroy_laser)
	
func onDestroy_laser():
	queue_free()

func initialize(initial_position: Vector2, initial_rotation: float, initial_source: Node2D):
	var primaryBody = find_child("primaryBody")
	primaryBody.position = initial_position
	primaryBody.rotation = initial_rotation
	source = initial_source
	SoundManager.play_sound(red_laser_sound_path)

func _process(delta):
	var primaryBody = find_child("primaryBody")
	
	for child in find_child("DuplicateOnEdges").get_children():
		if child.name != "primaryBody":
			child.position = primaryBody.position + child.duplicate_offset
