extends Area2D

@onready var stationBody = $".."

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody2D:
		var direction = (stationBody.global_position - body.global_position).normalized()
		body.dockTowards(direction)
