extends Node2D

var ZONE_WIDTH := 6400
var ZONE_HEIGHT := 6400
var VIEW_DISTANCE : Vector2

func _ready():
	$Player.position = Vector2(50,50)
	VIEW_DISTANCE = Vector2(get_viewport_rect().size.x, get_viewport_rect().size.y)
	#VIEW_DISTANCE = Vector2(200,200)

	print("boundaries for zone:")
	print("Width: " + str(ZONE_WIDTH) + " Height: " + str(ZONE_HEIGHT))
	print("View distance: (" + str(VIEW_DISTANCE.x) + "," + str(VIEW_DISTANCE.y) + ")")
