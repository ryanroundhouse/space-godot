extends Node2D

var BOTTOM_LIMIT: int
var TOP_LIMIT: int
var LEFT_LIMIT: int
var RIGHT_LIMIT: int
@onready var primary_body = $primaryBody

func _ready():
	if primary_body:
		if primary_body.has_signal("primaryBodyWarped"):
			primary_body.connect("primaryBodyWarped", onPrimaryBodyWarped)
	
	var zone = find_parent("Zone")
	BOTTOM_LIMIT = zone.ZONE_HEIGHT / 2 - zone.VIEW_DISTANCE.y
	TOP_LIMIT = -zone.ZONE_HEIGHT / 2 + zone.VIEW_DISTANCE.y
	RIGHT_LIMIT = zone.ZONE_WIDTH / 2 - zone.VIEW_DISTANCE.x
	LEFT_LIMIT = -zone.ZONE_WIDTH / 2 + zone.VIEW_DISTANCE.x
	print("top limit: " + str(TOP_LIMIT))
	print("bottom limit: " + str(BOTTOM_LIMIT))
	print("left limit: " + str(LEFT_LIMIT))
	print("right limit: " + str(RIGHT_LIMIT))

func onPrimaryBodyWarped():		
	if has_node("topBody"):
		$topBody.queue_free()
	if has_node("bottomBody"):
		$bottomBody.queue_free()
	if has_node("leftBody"):
		$leftBody.queue_free()
	if has_node("rightBody"):
		$rightBody.queue_free()
	if has_node("diagTopLeftBody"):
		$diagTopLeftBody.queue_free()
	if has_node("diagTopRightBody"):
		$diagTopRightBody.queue_free()
	if has_node("diagBottomLeftBody"):
		$diagBottomLeftBody.queue_free()
	if has_node("diagBottomRightBody"):
		$diagBottomRightBody.queue_free()
	
	duplicateIfNecessary()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(get_parent().name + " is at " + "(" + str(primary_body.global_position.x) + "," + str(primary_body.global_position.y) + ")")
	duplicateIfNecessary();

func duplicateIfNecessary():
	var topBody = has_node("topBody")
	var bottomBody = has_node("bottomBody")
	var leftBody = has_node("leftBody")
	var rightBody = has_node("rightBody")
	var diagTopLeftBody = has_node("diagTopLeftBody")
	var diagTopRightBody = has_node("diagTopRightBody")
	var diagBottomLeftBody = has_node("diagBottomLeftBody")
	var diagBottomRightBody = has_node("diagBottomRightBody")
		
	var zone = find_parent("Zone")
		
	# create bottom-clone if a screen away from the top
	if TooCloseToTop(primary_body.global_position):
		if not bottomBody:
			duplicateBody("bottomBody", Vector2(0,zone.ZONE_HEIGHT))
	else:
		if bottomBody:
			#print("freeing bottomBody")
			$bottomBody.queue_free()
	# create top-clone if a screen away from the bottom
	if TooCloseToBottom(primary_body.global_position):
		if not topBody:
			duplicateBody("topBody", Vector2(0,-zone.ZONE_HEIGHT))
	else:
		if topBody:
			#print("freeing topBody")
			$topBody.queue_free()
	# create right-clone if a screen away from the left
	if TooCloseToLeft(primary_body.global_position):
		if not rightBody:
			duplicateBody("rightBody", Vector2(zone.ZONE_WIDTH,0))
	else:
		if rightBody:
			$rightBody.queue_free()
	# create left-clone if a screen away from the right
	if TooCloseToRight(primary_body.global_position):
		if not leftBody:
			duplicateBody("leftBody", Vector2(-zone.ZONE_WIDTH,0))
	else:
		if leftBody:
			$leftBody.queue_free()

	# create top left clone if too close to bottom right
	if TooCloseToBottom(primary_body.global_position) && TooCloseToRight(primary_body.global_position):
		if not diagTopLeftBody:
			duplicateBody("diagTopLeftBody", Vector2(-zone.ZONE_WIDTH,-zone.ZONE_HEIGHT))
	else:
		if diagTopLeftBody:
			$diagTopLeftBody.queue_free()

	# create top right clone if too close to bottom left
	if TooCloseToBottom(primary_body.global_position) && TooCloseToLeft(primary_body.global_position):
		if not diagTopRightBody:
			duplicateBody("diagTopRightBody", Vector2(zone.ZONE_WIDTH,-zone.ZONE_HEIGHT))
	else:
		if diagTopRightBody:
			$diagTopRightBody.queue_free()

	# create bottom right clone if too close to top left
	if TooCloseToTop(primary_body.global_position) && TooCloseToLeft(primary_body.global_position):
		if not diagBottomRightBody:
			duplicateBody("diagBottomRightBody", Vector2(zone.ZONE_WIDTH,zone.ZONE_HEIGHT))
	else:
		if diagBottomRightBody:
			$diagBottomRightBody.queue_free()

	# create bottom left clone if too close to top right
	if TooCloseToTop(primary_body.global_position) && TooCloseToRight(primary_body.global_position):
		if not diagBottomLeftBody:
			duplicateBody("diagBottomLeftBody", Vector2(-zone.ZONE_WIDTH,zone.ZONE_HEIGHT))
	else:
		if diagBottomLeftBody:
			$diagBottomLeftBody.queue_free()

func duplicateBody(newBodyName: String, offset: Vector2):
	var primaryBody = find_child("primaryBody")
	var newArea = primaryBody.duplicate()
	newArea.name = newBodyName
	newArea.duplicate_offset = offset
	newArea.position += offset
	if get_parent() is RigidBody2D:
		newArea.rotation = primaryBody.angular_velocity

	#print("adding " + newBodyName + " at (" + str(newArea.position.x) + "," + str(newArea.position.y) + ")")
	
	add_child(newArea)
	


func TooCloseToBottom(initial_position: Vector2):
	var limit = BOTTOM_LIMIT
	#if get_parent().name == "JumpPoint":
		#print("too close to bot: " + str(initial_position.y) + " >= " + str(limit))
	if initial_position.y >= limit:
		#print("too close to bottom")
		return true
	return false
func TooCloseToTop(initial_position: Vector2):
	var limit = TOP_LIMIT
	#if get_parent().name == "JumpPoint":
		#print("too close to top: " + str(initial_position.y) + " <= " + str(limit))
	if initial_position.y <= limit:
		#print("too close to top")
		return true
	return false
func TooCloseToLeft(initial_position: Vector2):
	var limit = LEFT_LIMIT
	#if get_parent().name == "JumpPoint":
		#print("too close to left: " + str(initial_position.x) + " <= " + str(limit))
	if initial_position.x <= limit:
		#print("too close to left")
		return true
	return false
func TooCloseToRight(initial_position: Vector2):
	var limit = RIGHT_LIMIT
	#if get_parent().name == "JumpPoint":
		#print("too close to right: " + str(initial_position.x) + " >= " + str(limit))
	if initial_position.x >= limit:
		#print("too close to right")
		return true
	return false
