extends Area2D

@export var direction := Vector2(1,0)
@export var rotation_speed := 1.0

signal primaryBodyWarped()

var isPrimary := false

func _physics_process(delta):
	position += direction * delta
	rotation += rotation_speed * delta
	if isPrimary:
		wrapToOtherSide()

func wrapToOtherSide():
	var zone = find_parent("Zone")
	if position.x >= zone.ZONE_WIDTH / 2:
		position.x = -zone.ZONE_WIDTH / 2
		emit_signal("primaryBodyWarped")
	elif position.x <= -zone.ZONE_WIDTH / 2:
		position.x = zone.ZONE_WIDTH / 2
		emit_signal("primaryBodyWarped")
	if position.y >= zone.ZONE_HEIGHT / 2:
		position.y = -zone.ZONE_HEIGHT / 2
		emit_signal("primaryBodyWarped")
	elif position.y <= -zone.ZONE_HEIGHT / 2:
		position.y = zone.ZONE_HEIGHT / 2
		emit_signal("primaryBodyWarped")
