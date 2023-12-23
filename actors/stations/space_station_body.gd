extends Area2D

var duplicate_offset: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", _on_body_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	print("station {station.name} entered by: {body.name}".format({"station.name": get_parent().get_parent().name, "body.name": body.name}))
	if body is CharacterBody2D:
		var push_direction = (body.global_position - global_position).normalized()
		var push_strength = 1000  # Adjust this value as needed
		body.velocity = push_direction * push_strength
