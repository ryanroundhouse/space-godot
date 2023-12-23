extends Node2D

#6400/8960

var ZONE_WIDTH := 6400
var ZONE_HEIGHT := 6400
var VIEW_DISTANCE : Vector2

var space_station_scene = preload("res://actors/stations/space_station.tscn")

func _ready():
	$Player.position = Vector2(0,0)
	VIEW_DISTANCE = Vector2(get_viewport_rect().size.x, get_viewport_rect().size.y)
	#VIEW_DISTANCE = Vector2(200,200)

	var station = space_station_scene.instantiate()
	station.name = "space_station"
	station.initialize(Vector2(-450,-450))
	station.add_to_group("space_stations")
	add_child(station)
