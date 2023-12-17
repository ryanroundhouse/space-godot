extends Node2D

func initialize(position: Vector2, direction: Vector2, rotation_speed: float):
	var primaryBody = find_child("primaryBody")
	primaryBody.position = position
	primaryBody.direction = direction
	primaryBody.rotation_speed = rotation_speed
	primaryBody.isPrimary = true
