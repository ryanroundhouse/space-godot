extends Node2D

var ZONE_WIDTH := 6400
var ZONE_HEIGHT := 6400
var VIEW_DISTANCE : Vector2

var space_station_scene = preload("res://actors/stations/space_station.tscn")
var turret_scene = preload("res://actors/obstacles/turret/turret.tscn")
var jump_point_scene = preload("res://actors/obstacles/jump_point.tscn")
var player_scene = preload("res://actors/players/player.tscn")
var asteroid_spawner_scene = preload("res://actors/spawners/asteroid_spawner.tscn")
var enemy_ship_spawner_scene = preload("res://actors/spawners/enemy_ship_spawner.tscn")
var cursor_manager_scene = preload("res://actors/hud/cursor_manager.tscn")

var music_path = "res://assets/music/journey_to_the_sun_stellardrone.mp3"
var background_texture = "res://assets/background/space1.jpg"

func _ready():
	SoundManager.play_bgm(music_path)
	VIEW_DISTANCE = Vector2(get_viewport_rect().size.x, get_viewport_rect().size.y)
	
	var stationPosition = Vector2(-450, -450)
	var launchPosition = Vector2(-308, -646)
	var launchVelocity = Vector2(300,-300)
	var launchDirection = 35.0
	var turretPosition = Vector2(-1000, -1000)
	var jumpPointPosition = Vector2(2400, 2000)
	
	var background : Sprite2D = $Background
	var background_texture = load(background_texture)
	background.texture = background_texture
	background.region_enabled = true
	background.region_rect = Rect2(Vector2.ZERO, Vector2(8960,8960))
	
	#load_asteroid_spawner(36)
	load_enemy_ship_spawner(1)
	load_cursor_spawner()
	
	spawn_station(stationPosition)
	#spawn_turret(turretPosition)
	#spawn_jump_point(jumpPointPosition)
	launch_player(launchPosition, launchVelocity, launchDirection)

func load_cursor_spawner():
	var cursor_manager = cursor_manager_scene.instantiate()
	add_child(cursor_manager)

func load_asteroid_spawner(number_of_asteroids):
	var asteroid_spawner = asteroid_spawner_scene.instantiate()
	asteroid_spawner.number_of_asteroids = number_of_asteroids
	add_child(asteroid_spawner)

func load_enemy_ship_spawner(number_of_enemy_ships):
	var enemy_ship_spawner = enemy_ship_spawner_scene.instantiate()
	enemy_ship_spawner.number_of_enemy_ships = number_of_enemy_ships
	add_child(enemy_ship_spawner)

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

func launch_player(launch_position: Vector2, launch_velocity: Vector2, launch_direction: float):
	var player = player_scene.instantiate()
	player.name = "Player" 
	player.add_to_group("Player")
	var playerPosition = launch_position
	var playerVelocity = launch_velocity
	var playerDirection = launch_direction
	add_child(player)
	player.launchFromDock(playerPosition, playerDirection, playerVelocity)

func spawn_station(station_position: Vector2):
	var station = space_station_scene.instantiate()
	station.name = "space_station"
	station.add_to_group("targettable")
	station.initialize(station_position)
	station.add_to_group("space_stations")
	add_child(station)
