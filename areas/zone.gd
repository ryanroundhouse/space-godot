extends Node2D

#6400/8960

var ZONE_WIDTH := 6400
var ZONE_HEIGHT := 6400
var VIEW_DISTANCE : Vector2
@onready var cursorSpawner = $CursorSpawner

var space_station_scene = preload("res://actors/stations/space_station.tscn")
var music_path = "res://assets/music/journey_to_the_sun_stellardrone.mp3"

func _ready():
	
	SoundManager.play_bgm(music_path)
	VIEW_DISTANCE = Vector2(get_viewport_rect().size.x, get_viewport_rect().size.y)

	var station = space_station_scene.instantiate()
	station.name = "space_station"
	station.add_to_group("targettable")
	var stationPosition = Vector2(-450, -450)
	var playerPosition = stationPosition + Vector2(150, -190)
	var playerVelocity = Vector2(300,-300)
	var playerDirection = (stationPosition - playerPosition).angle() - 89.7
	station.initialize(stationPosition)
	station.add_to_group("space_stations")
	cursorSpawner.create_target_cursor(station)
	add_child(station)
	$Player.launchFromDock(playerPosition, playerDirection, playerVelocity)
