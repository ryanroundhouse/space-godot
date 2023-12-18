extends Node2D

var ZONE_WIDTH := 800
var ZONE_HEIGHT := 800
var VIEW_DISTANCE : Vector2

func _ready():
	$Player.position = Vector2(50,50)
	#VIEW_DISTANCE = Vector2(get_viewport_rect().size.x, get_viewport_rect().size.y)
	VIEW_DISTANCE = Vector2(200,200)
