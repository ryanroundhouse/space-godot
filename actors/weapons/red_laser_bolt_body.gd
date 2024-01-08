extends Area2D

var speed = 1400
var max_range = 1100.0
var traveled_distance = 0.0
var duplicate_offset: Vector2

signal destroy_laser()

func _ready():
	rotation += deg_to_rad(-90)
	connect("body_entered", _on_body_entered)
	connect("area_entered", _on_area_entered)

func _on_body_entered(body):
	var red_laser_bolt = get_parent().get_parent()
	if body != red_laser_bolt.source:
		if body.has_method("damage"):
			body.damage(red_laser_bolt.damage)
		emit_signal("destroy_laser")
	
func _on_area_entered(area):
	if area.has_method("damage"):
		var red_laser_bolt = get_parent().get_parent()
		area.damage(red_laser_bolt.damage)
	emit_signal("destroy_laser")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var movement = Vector2(speed, 0).rotated(rotation) * delta
	position += movement
	traveled_distance += movement.length()

	if traveled_distance > max_range:
		emit_signal("destroy_laser")
