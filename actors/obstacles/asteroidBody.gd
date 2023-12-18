extends RigidBody2D

@export var direction := Vector2(1,0)
@export var rotation_speed := 1.0

signal primaryBodyWarped()
signal blowUp()

var isPrimary := false
var duplicate_offset: Vector2

#func _ready():
	#connect("body_entered", _on_body_entered)


#func _on_body_entered(body):
	#print("Entered: ", body.name)

func damage(weapon):
	#print("I should blow up")
	emit_signal("blowUp", position)

func _integrate_forces(state):
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
