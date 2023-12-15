extends RigidBody2D
	
var ZONE_WIDTH := 5120
var ZONE_HEIGHT := 5120

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _integrate_forces(state):
	# move asteroid
	
	# wrap asteroid to opposite side of zone
	if position.x > ZONE_WIDTH / 2:
		var pos = state.get_transform()
		pos.origin.x = -ZONE_WIDTH / 2
		state.set_transform(pos)
	elif position.x < -ZONE_WIDTH / 2:
		var pos = state.get_transform()
		pos.origin.x = ZONE_WIDTH / 2
		state.set_transform(pos)
	if position.y > ZONE_HEIGHT / 2:
		var pos = state.get_transform()
		pos.origin.y = -ZONE_HEIGHT / 2
		state.set_transform(pos)
	elif position.y < -ZONE_HEIGHT / 2:
		var pos = state.get_transform()
		pos.origin.y = ZONE_HEIGHT / 2
		state.set_transform(pos)
