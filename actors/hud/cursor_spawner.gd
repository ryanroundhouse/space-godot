extends Node2D

var hud_cursor_scene = preload("res://actors/hud/hud_cursor.tscn")

var current_target : Node2D = null
var current_cursor : Node2D = null

func _process(delta):
	if Input.is_action_just_pressed("next_target"):
		next_target()

func create_target_cursor(hud_target: Node):
	print("targetting " + hud_target.name)
	if current_cursor:
		current_cursor.queue_free()
	var hud_cursor = hud_cursor_scene.instantiate()
	var cursor_icon_path = "res://assets/hud/arrow1.png"
	if hud_target.is_in_group("hostile"):
		cursor_icon_path = "res://assets/hud/arrow2.png"
	add_child(hud_cursor)
	hud_cursor.initialize(hud_target, cursor_icon_path)
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
			var next_target_object = targets[0]
			if index >= 0 and index < targets.size() - 1:
				next_target_object = targets[index + 1]

			if next_target_object != current_target:
				create_target_cursor(next_target_object)
		else:
			create_target_cursor(targets[0])
