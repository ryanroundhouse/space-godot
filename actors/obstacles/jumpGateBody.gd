extends Area2D

var duplicate_offset: Vector2
signal promote_body_entered(body)
signal promote_body_exited(body)

func _process(delta):
	global_rotation_degrees += 5 * delta

func _on_body_entered(body):
	emit_signal("promote_body_entered", body)


func _on_body_exited(body):
	emit_signal("promote_body_exited", body)
