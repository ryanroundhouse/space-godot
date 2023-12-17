extends Area2D

@export var direction := Vector2(1,0)
@export var rotation_speed := 1.0

signal primaryBodyWarped()

var isPrimary := false

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	print("Entered: ", body.name)
	var normal = calculate_collision_normal(body)
	print("normal: (" + str(normal.x) + "," + str(normal.y) + ")")
	body.velocity = normal
	direction = -normal

func calculate_collision_normal(area):
	return (area.global_position - global_position) * 20

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
