extends Node2D

var duplicate_offset

func initialize(initial_position: Vector2):
	var primaryBody = find_child("primaryBody")
	primaryBody.position = initial_position
