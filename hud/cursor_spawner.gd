extends Node2D

var hud_cursor_scene = preload("res://hud/hud_cursor.tscn")

func Create_hud_cursor(hud_target: Node):
	var hud_cursor = hud_cursor_scene.instantiate() 
	add_child(hud_cursor)
	hud_cursor.initialize(hud_target)
	
