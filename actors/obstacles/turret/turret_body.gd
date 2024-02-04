extends Area2D

var health = 20
signal blowUp()

var duplicate_offset: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func damage(damage_amount):
	print("I'm a turret and should pop")
	health -= damage_amount
	health = max(health, 0)
	if !health:
		emit_signal("blowUp")
