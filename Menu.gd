extends Node2D

var world_scene := preload("res://world.tscn")

func _on_start_game_button_pressed():
	get_tree().change_scene_to_packed(world_scene)
