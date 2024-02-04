extends Area2D

var duplicate_offset: Vector2
var health = 20
signal blowUp()

var isPrimary := false
signal primaryBodyWarped()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if World.IS_DEBUG:
		var label = get_node("DebugLabel") as Label
		if label:
			label.rotation = -rotation
			label.text = "Pos: %s" % position
	if isPrimary:
		wrapToOtherSide()

func damage(damage_amount):
		health -= damage_amount
		health = max(health, 0)
		if !health:
			emit_signal("blowUp")

func wrapToOtherSide():
	var zone = find_parent("Zone")
	var top_ship_node = get_parent().get_parent()
	if top_ship_node.position.x >= zone.ZONE_WIDTH / 2:
		top_ship_node.position.x = -zone.ZONE_WIDTH / 2
		emit_signal("primaryBodyWarped")
	elif top_ship_node.position.x <= -zone.ZONE_WIDTH / 2:
		top_ship_node.position.x = zone.ZONE_WIDTH / 2
		emit_signal("primaryBodyWarped")
	if top_ship_node.position.y >= zone.ZONE_HEIGHT / 2:
		top_ship_node.position.y = -zone.ZONE_HEIGHT / 2
		emit_signal("primaryBodyWarped")
	elif top_ship_node.position.y <= -zone.ZONE_HEIGHT / 2:
		top_ship_node.position.y = zone.ZONE_HEIGHT / 2
		emit_signal("primaryBodyWarped")

func get_closest_body_dupe_position(position: Vector2):
	return get_parent().get_parent().get_closest_body_dupe_position(position)
