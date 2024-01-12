extends Node2D

var hud_cursor_scene = preload("res://hud/hud_cursor.tscn")

var current_target : Node = null
var current_cursor : Node2D = null

func _process(delta):
	if Input.is_action_just_pressed("next_target"):
		next_target()

func Create_hud_cursor(hud_target: Node):
	if current_cursor:
		current_cursor.queue_free()
	var hud_cursor = hud_cursor_scene.instantiate()
	add_child(hud_cursor)
	hud_cursor.initialize(hud_target)
	if hud_target.has_signal("blowUp"):
		hud_target.connect("blowUp", next_target)
	current_target = hud_target
	current_cursor = hud_cursor

func next_target():
	var targets = get_tree().get_nodes_in_group("targettable")
	targets.sort()
	if targets:
		if current_target:
			var index = targets.find(current_target)
			if index >= 0 and index < targets.size() - 1:
				Create_hud_cursor(targets[index + 1])
			else:
				Create_hud_cursor(targets[0])
		else:
			Create_hud_cursor(targets[0])
