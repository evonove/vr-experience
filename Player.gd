extends RigidBody

var position
var origin
var collision
var new_position

func _ready():
	origin = get_node("PlayerOrigin")
	position = origin.get_translation()
	collision = get_node("PlayerCollisionShape")
	new_position = collision.get_translation()
	
func _physics_process(delta):
	position = origin.get_translation()

func _on_LeftFootArea_body_entered(body):
	if body.get_name() == "BottomFloor" or body.get_name() == "UpperFloor1":
		if position != new_position:
	#	position = origin.get_translation()
			print(position)
			print(new_position)
			collision.set_translation(position)
			new_position = position


func _on_RightFootArea_body_entered(body):
	if body.get_name() == "BottomFloor" or body.get_name() == "UpperFloor1":
		if position != new_position:
			print(position)
			print(new_position)
			collision.set_translation(position)
			new_position = position
