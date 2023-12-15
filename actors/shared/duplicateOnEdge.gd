extends Node2D

var ZONE_WIDTH := 5120
var ZONE_HEIGHT := 5120

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
	
	var parent = get_parent()
	
	#print("parent position: (" + str(parent.position.x) + "," + str(parent.position.y) + ")")
	
	# create top-clone if a screen away from the bottom
	if TooCloseToBottom(parent.position.x, parent.position.y):
		if not topBody:
			duplicateBody("topBody", Vector2(0,-ZONE_HEIGHT))
	else:
		if topBody:
			$topBody.queue_free()
	# create bottom-clone if a screen away from the top
	if TooCloseToTop(parent.position.x, parent.position.y):
		if not bottomBody:
			duplicateBody("bottomBody", Vector2(0,ZONE_HEIGHT))
	else:
		if bottomBody:
			$bottomBody.queue_free()
	# create right-clone if a screen away from the left
	if TooCloseToLeft(parent.position.x, parent.position.y):
		if not rightBody:
			duplicateBody("topBody", Vector2(ZONE_WIDTH,0))
	else:
		if rightBody:
			$rightBody.queue_free()
	# create left-clone if a screen away from the right
	if TooCloseToRight(parent.position.x, parent.position.y):
		if not leftBody:
			duplicateBody("topBody", Vector2(-ZONE_WIDTH,0))
	else:
		if leftBody:
			$leftBody.queue_free()
	# create top right clone
	if TooCloseToBottom(parent.position.x, parent.position.y) && TooCloseToLeft(parent.position.x, parent.position.y):
		if not diagTopRightBody:
			duplicateBody("topBody", Vector2(ZONE_WIDTH,-ZONE_HEIGHT))
	else:
		if diagTopRightBody:
			$diagTopRightBody.queue_free()
	# create top left clone
	if TooCloseToBottom(parent.position.x, parent.position.y) && TooCloseToRight(parent.position.x, parent.position.y):
		if not diagTopLeftBody:
			duplicateBody("topBody", Vector2(-ZONE_WIDTH,-ZONE_HEIGHT))
	else:
		if diagTopLeftBody:
			$diagTopLeftBody.queue_free()
	# create bottom left clone
	if TooCloseToTop(parent.position.x, parent.position.y) && TooCloseToRight(parent.position.x, parent.position.y):
		if not diagBottomLeftBody:
			duplicateBody("topBody", Vector2(-ZONE_WIDTH,ZONE_HEIGHT))
	else:
		if diagBottomLeftBody:
			$diagBottomLeftBody.queue_free()
	# create bottom right clone
	if TooCloseToTop(parent.position.x, parent.position.y) && TooCloseToLeft(parent.position.x, parent.position.y):
		if not diagBottomRightBody:
			duplicateBody("topBody", Vector2(ZONE_WIDTH,ZONE_HEIGHT))
	else:
		if diagBottomRightBody:
			$diagBottomRightBody.queue_free()

func duplicateBody(newBodyName: String, offset: Vector2):
	var newBody = $primaryBody.duplicate()
	newBody.name = newBodyName
	newBody.position += offset
	add_child(newBody)
	
func TooCloseToBottom(x: int, y: int):
	if y > ZONE_HEIGHT / 2 - get_viewport_rect().size.y:
		#print("bottom")
		return true
	return false
func TooCloseToTop(x: int, y: int):
	if y < -ZONE_HEIGHT / 2 + get_viewport_rect().size.y:
		#print("top")
		return true
	return false
func TooCloseToLeft(x: int, y: int):
	if x > ZONE_WIDTH / 2 - get_viewport_rect().size.x:
		#print("left")
		return true
	return false
func TooCloseToRight(x: int, y: int):
	if x < -ZONE_WIDTH / 2 + get_viewport_rect().size.x:
		#print("right")
		return true
	return false
