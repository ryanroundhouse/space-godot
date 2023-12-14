extends Node2D

var ZONE_WIDTH := 5120
var ZONE_HEIGHT := 5120

func duplicateBody(newBodyName: String, x = null, y = null):
	var newBody = $primaryBody.duplicate()
	newBody.name = newBodyName
	print("X " + str(newBody.position.x) + " -> " + str(x) + " Y " + str(newBody.position.y) + " -> " + str(y))
	if x != null:
		newBody.position.x = x
	if y != null:
		newBody.position.y = y
	add_child(newBody);
	
func TooCloseToBottom(x: int, y: int):
	return y > ZONE_HEIGHT / 2 - get_viewport_rect().size.y
func TooCloseToTop(x: int, y: int):
	return y < -ZONE_HEIGHT / 2 + get_viewport_rect().size.y
func TooCloseToLeft(x: int, y: int):
	return x < ZONE_WIDTH / 2 - get_viewport_rect().size.x
func TooCloseToRight(x: int, y: int):
	return x > -ZONE_WIDTH / 2 + get_viewport_rect().size.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var topBody = $topBody
	var bottomBody = $bottomBody
	var leftBody = $leftBody
	var rightBody = $rightBody
	var diagTopLeftBody = $diagTopLeftBody
	var diagTopRightBody = $diagTopRightBody
	var diagBottomLeftBody = $diagBottomLeftBody
	var diagBottomRightBody = $diagBottomRightBody
	
	# create top-clone if a screen away from the bottom
	if TooCloseToBottom(position.x, position.y):
		if not topBody:
			duplicateBody("topBody", null, $primaryBody.position.y - ZONE_HEIGHT)
	else:
		if topBody:
			topBody.queue_free()
	# create bottom-clone if a screen away from the top
	if TooCloseToTop(position.x, position.y):
		if not bottomBody:
			duplicateBody("bottomBody", null, $primaryBody.position.y + ZONE_HEIGHT)
	else:
		if bottomBody:
			bottomBody.queue_free()
	# create right-clone if a screen away from the left
	if TooCloseToLeft(position.x, position.y):
		if not rightBody:
			duplicateBody("rightBody", $primaryBody.position.x + ZONE_WIDTH, null)
	else:
		if rightBody:
			rightBody.queue_free()
	# create left-clone if a screen away from the right
	if TooCloseToRight(position.x, position.y):
		if not leftBody:
			duplicateBody("leftBody", $primaryBody.position.x - ZONE_WIDTH, null)
	else:
		if leftBody:
			leftBody.queue_free()
	# create top right clone
	if TooCloseToBottom(position.x, position.y) && TooCloseToLeft(position.x, position.y):
		if not diagTopRightBody:
			duplicateBody("diagTopRightBody", $primaryBody.position.x + ZONE_WIDTH, $primaryBody.position.y - ZONE_HEIGHT)
	else:
		if diagTopRightBody:
			diagTopRightBody.queue_free()
	# create top left clone
	if TooCloseToBottom(position.x, position.y) && TooCloseToRight(position.x, position.y):
		if not diagTopLeftBody:
			duplicateBody("diagTopLeftBody", $primaryBody.position.x - ZONE_WIDTH, $primaryBody.position.y - ZONE_HEIGHT)
	else:
		if diagTopLeftBody:
			diagTopLeftBody.queue_free()
	# create bottom left clone
	if TooCloseToTop(position.x, position.y) && TooCloseToRight(position.x, position.y):
		if not diagBottomLeftBody:
			duplicateBody("diagBottomLeftBody", $primaryBody.position.x - ZONE_WIDTH, $primaryBody.position.y + ZONE_HEIGHT)
	else:
		if diagBottomLeftBody:
			diagBottomLeftBody.queue_free()
	# create bottom right clone
	if TooCloseToTop(position.x, position.y) && TooCloseToLeft(position.x, position.y):
		if not diagBottomRightBody:
			duplicateBody("diagBottomRightBody", $primaryBody.position.x + ZONE_WIDTH, $primaryBody.position.y + ZONE_HEIGHT)
	else:
		if diagBottomRightBody:
			diagBottomRightBody.queue_free()
