extends Area2D

var duplicate_offset: Vector2

func _process(delta):
	global_rotation_degrees += 5 * delta
