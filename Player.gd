extends RigidBody


func _on_LeftHandController_button_pressed(button):
	print("left ", button)


func _on_RightHandController_button_pressed(button):
	print("right ", button)

func _physics_process(delta):
	var right_foot : = $PlayerOrigin/RightFootController
	right_foot.set_rumble(1.0)
	Input.start_joy_vibration(right_foot.get_joystick_id(), 1.0, 1.0, 10000)
	var left_foot := $PlayerOrigin/LeftFootController
	Input.start_joy_vibration(left_foot.get_joystick_id(), 1.0, 1.0, 10000)
	left_foot.set_rumble(1.0)