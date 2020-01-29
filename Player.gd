extends RigidBody

var collision
var new_position
var leftfoot
var rightfoot
var positionl
var positionr
var camera
var position
var changel = false
var changer = false

func _ready():
	leftfoot = get_node("PlayerOrigin/LeftFootController/LeftFootArea")
	positionl = leftfoot.get_translation()
	rightfoot = get_node("PlayerOrigin/RightFootController/RightFootArea")
	positionr = rightfoot.get_translation()
	camera = get_node("PlayerOrigin")
	position = camera.get_translation()
	collision = get_node("PlayerCollisionShape")
	new_position = collision.get_translation()
	
func _process(delta):
	positionl = leftfoot.get_translation()
	positionr = rightfoot.get_translation()
	if changel:
		print("piede sinistro: ", positionl)
		new_position = collision.set_translation(position)
		print("CollisionPlayer", collision.get_translation())
#		print("nuova posizione: ", positionl)
		changel = false
	elif changer:
		print("piede destro: ", positionr)
		new_position = collision.set_translation(positionr)
		print("CollisionPlayer", collision.get_translation())
#		print("nuova posizione: ", position)
		changer = false

func _on_LeftFootArea_body_entered(body):
	if body.get_name() == "BottomFloor" or body.get_name() == "UpperFloor1":
		if positionl != new_position or positionr != new_position:
			changel = true


func _on_RightFootArea_body_entered(body):
	if body.get_name() == "BottomFloor" or body.get_name() == "UpperFloor1":
		if positionl != new_position or positionr != new_position:
			changer = true
