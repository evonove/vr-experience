extends KinematicBody

var vel = Vector3()
var force = 9.81*10
var pos = Vector3(0,1,0)
var move = false

func _on_Area_body_entered(body):
	if body.get_name() == "Player":
		move = true
	
func _physics_process(delta):
	if move:
		vel.y = force* delta
		move_and_slide(vel, pos)