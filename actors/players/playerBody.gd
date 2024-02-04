extends Area2D

var duplicate_offset: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_closest_body_dupe_position(target_position: Vector2) -> Vector2:
	return get_parent().get_parent().get_closest_body_dupe_position(target_position)

func dockTowards(direction: Vector2):
	get_parent().get_parent().dockTowards(direction)

func damage(amount):
	get_parent().get_parent().damage(amount)
