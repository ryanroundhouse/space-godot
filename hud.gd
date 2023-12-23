extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$StationCursor.position = Vector2(-250,0)
	pass # Replace with function body.


func _process(delta):
	var player = get_parent().find_child("Player")
	var stations = get_tree().get_nodes_in_group("space_stations")
	
	if player && stations.size() > 0:
		var player_position = player.global_position
		var station_position = stations[0].global_position
		var viewport_rect = get_viewport_rect()
		var camera = get_viewport().get_camera_2d()

		# Calculate the station's position relative to the camera's viewport
		var relative_station_position = station_position - camera.global_position + viewport_rect.size / 2

		# Check if station is visible on the screen
		if viewport_rect.has_point(relative_station_position):
			$StationCursor.visible = false  # Hide cursor if station is visible
		else:
			$StationCursor.visible = true
			var center = Vector2(0, 0)  # Center of the rectangle
			var rect_width = viewport_rect.size.x - 100
			var rect_height = viewport_rect.size.y - 100
			var direction = (station_position - player_position).normalized()

			var vector_to_boundary = get_vector_to_boundary(center, rect_width, rect_height, direction)
			$StationCursor.global_position = player_position + vector_to_boundary
			$StationCursor.rotation = atan2(direction.y, direction.x)


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
