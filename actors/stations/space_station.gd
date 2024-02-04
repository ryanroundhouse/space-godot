extends Node2D

var duplicate_offset

func initialize(initial_position: Vector2):
	global_position = initial_position

func get_closest_body_dupe_position(target_position: Vector2) -> Vector2:
	var closest_position: Vector2 = Vector2.ZERO
	var min_distance: float = INF  # Initialize with infinity

	for body in find_child("DuplicateOnEdges").get_children():
		if body.is_in_group("BodyDupe"):
			var distance = target_position.distance_to(body.global_position)
			if distance < min_distance:
				min_distance = distance
				closest_position = body.global_position

	return closest_position
