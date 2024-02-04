extends Area2D

@onready var stationBody = $".."

func _on_body_entered(body):
	var direction = (stationBody.global_position - body.global_position).normalized()
	body.dockTowards(direction)
