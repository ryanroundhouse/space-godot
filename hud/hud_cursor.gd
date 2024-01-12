extends Node2D

@export var displayStationCursor := true
var targetOfCursor: Node
var player : Node

func initialize(target: Node):
	targetOfCursor = target
	player = find_parent("Zone").find_child("Player")

func _process(delta):
	if not targetOfCursor:
		queue_free()
		return
		
	if player && targetOfCursor:
		var player_position = player.global_position
		var target_position = targetOfCursor.global_position
		var viewport_rect = get_viewport_rect()
		var camera = get_viewport().get_camera_2d()

		# Calculate the station's position relative to the camera's viewport
		var relative_station_position = target_position - camera.global_position + viewport_rect.size / 2

		# Check if station is visible on the screen
		if viewport_rect.has_point(relative_station_position):
			visible = false  # Hide cursor if station is visible
		else:
			visible = true
			var center = Vector2(0, 0)  # Center of the rectangle
			var rect_width = viewport_rect.size.x - 100
			var rect_height = viewport_rect.size.y - 100
			var direction = (target_position - player_position).normalized()

			var vector_to_boundary = get_vector_to_boundary(center, rect_width, rect_height, direction)
			global_position = player_position + vector_to_boundary
			rotation = atan2(direction.y, direction.x)


func get_vector_to_boundary(center, rect_width, rect_height, direction):
	var normalized_direction = direction.normalized()

	# Rectangle's half dimensions
	var half_width = rect_width * 0.5
	var half_height = rect_height * 0.5

	# Calculate intersection times for each boundary
	var time_to_top_bottom = INF
	var time_to_left_right = INF

	if normalized_direction.y != 0:
		time_to_top_bottom = half_height / abs(normalized_direction.y)
	if normalized_direction.x != 0:
		time_to_left_right = half_width / abs(normalized_direction.x)

	# Find the smallest time (first boundary hit)
	var time_to_boundary = min(time_to_top_bottom, time_to_left_right)

	# Calculate the intersection point
	var intersection_point = normalized_direction * time_to_boundary

	# Create a vector from the center to the intersection point
	var vector_to_boundary = center + intersection_point

	return vector_to_boundary
