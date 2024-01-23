extends Area2D

var duplicate_offset: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if World.IS_DEBUG:
		var label = get_node("DebugLabel") as Label
		if label:
			label.rotation = -rotation
			label.text = "Pos: %s" % position
