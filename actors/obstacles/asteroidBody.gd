extends Area2D

@export var direction := Vector2(1,0)

signal primaryBodyWarped()

var isPrimary := false

func _physics_process(delta):
	position += direction * delta
	if isPrimary:
		wrapToOtherSide()

func wrapToOtherSide():
	var world = find_parent("World")
	if position.x >= world.ZONE_WIDTH / 2:
		position.x = -world.ZONE_WIDTH / 2
		print("wrapping to left at " + str(position.y))
		emit_signal("primaryBodyWarped")
	elif position.x <= -world.ZONE_WIDTH / 2:
		position.x = world.ZONE_WIDTH / 2
		print("wrapping to right at " + str(position.y))
		emit_signal("primaryBodyWarped")
	if position.y >= world.ZONE_HEIGHT / 2:
		position.y = -world.ZONE_HEIGHT / 2
		print("wrapping to top at " + str(position.y))
		emit_signal("primaryBodyWarped")
	elif position.y <= -world.ZONE_HEIGHT / 2:
		position.y = world.ZONE_HEIGHT / 2
		print("wrapping to bottom at " + str(position.y))
		emit_signal("primaryBodyWarped")
