extends Node2D

var destination := "new_system"

func on_promote_body_entered(body):
	if body.has_method("set_jump_destination"):
		body.set_jump_destination(destination)

func _on_promote_body_exited(body):
	if body.has_method("remove_jump_destination"):
		body.remove_jump_destination()


func _process(delta):
	var primaryBody = find_child("primaryBody")
	
	for child in find_child("DuplicateOnEdges").get_children():
		if child.name != "primaryBody":
			child.position = primaryBody.position + child.duplicate_offset
