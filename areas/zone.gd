extends Node2D

#6400/8960

var ZONE_WIDTH := 6400
var ZONE_HEIGHT := 6400
var VIEW_DISTANCE : Vector2
@onready var cursorSpawner = $CursorSpawner

var space_station_scene = preload("res://actors/stations/space_station.tscn")
var turret_scene = preload("res://actors/obstacles/turret/turret.tscn")
var jump_point_scene = preload("res://actors/obstacles/jump_point.tscn")
var music_path = "res://assets/music/journey_to_the_sun_stellardrone.mp3"

func _ready():
	
	SoundManager.play_bgm(music_path)
	VIEW_DISTANCE = Vector2(get_viewport_rect().size.x, get_viewport_rect().size.y)
	
	var stationPosition = Vector2(-450, -450)
	var turretPosition = Vector2(-1000, -1000)
	var jumpPointPosition = Vector2(2400, 2000)
	
	spawn_station(stationPosition)
	spawn_turret(turretPosition)
	spawn_jump_point(jumpPointPosition)
	launch_player(stationPosition)

func spawn_jump_point(jump_point_position: Vector2):
	var jump_point = jump_point_scene.instantiate()
	jump_point.destination = "spawn_jump_destination"
	jump_point.name = "spawned jump point"
	jump_point.global_position = jump_point_position
	jump_point.add_to_group("targettable")
	add_child(jump_point)

func spawn_turret(turret_position: Vector2):
	var turret = turret_scene.instantiate()
	turret.name = "spawned turret"
	turret.global_position = turret_position
	turret.add_to_group("targettable")
	add_child(turret)

func launch_player(launch_position: Vector2):
	var playerPosition = launch_position + Vector2(150, -190)
	var playerVelocity = Vector2(300,-300)
	var playerDirection = (launch_position - playerPosition).angle() - 89.7
	$Player.launchFromDock(playerPosition, playerDirection, playerVelocity)

func spawn_station(station_position: Vector2):
	var station = space_station_scene.instantiate()
	station.name = "space_station"
	station.add_to_group("targettable")
	station.initialize(station_position)
	station.add_to_group("space_stations")
	add_child(station)
