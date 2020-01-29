extends ARVROrigin

var rigidBody
var position

func _ready():
	rigidBody = get_node("Player")
	position = rigidBody.get_translation()
	print("Position Player",position)
	
func _physics_process(delta):
	print("Position Player",position)