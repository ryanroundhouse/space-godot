extends Node2D

func initialize(position: Vector2, direction: Vector2):
	var primaryBody = find_child("primaryBody")
	primaryBody.position = position
	primaryBody.direction = direction
	primaryBody.isPrimary = true
