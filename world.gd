extends Node2D

var ZONE_WIDTH := 6400
var ZONE_HEIGHT := 6400
var VIEW_DISTANCE : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.position = Vector2(50,50)
	VIEW_DISTANCE = Vector2(get_viewport_rect().size.x, get_viewport_rect().size.y)

