extends Node2D

var duplicate_offset

func initialize(initial_position: Vector2):
	var primaryBody = find_child("primaryBody")
	position = initial_position
	#primaryBody.position = initial_position
