extends RigidBody

var is_moving = false
onready var player = get_node("../Player")

func _on_Area_body_entered(body):
	if body.get_name() == "Player":
		player.set_translation(Vector3(0.6,5.549,-0.53))
		print("Player is on the bridge")
		is_moving = true


func move():
	if (is_moving):
		apply_torque_impulse(Vector3(0,0,5))