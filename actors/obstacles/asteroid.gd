extends Node2D

func initialize(position: Vector2, direction: Vector2, rotation_speed: int, scale: Vector2):
	var primaryBody = find_child("primaryBody")
	primaryBody.position = position
	primaryBody.direction = direction
	primaryBody.rotation_speed = rotation_speed
	primaryBody.isPrimary = true
	
	var mainSprite = find_child("MainSprite")
	mainSprite.scale *= scale;
	var collision = find_child("CollisionShape2D")
	collision.scale *= scale;
