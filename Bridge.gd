extends Spatial

var timer = Timer.new()

func timer_setup():
    timer.set_autostart(false)
    timer.set_wait_time(2)
    timer.process_mode = 1
    add_child(timer)

func _on_timer_timeout():
    $Boards.apply_torque_impulse(Vector3(0.001,0,0))

func _ready():
    timer.connect("timeout", self, "_on_timer_timeout")
    timer_setup()

func _on_Board1_area_entered(area):
	if area.get_name() == "RightFootArea" or area.get_name() == "LeftFootArea":
		$Boards.rotate_x(0.03)
		timer.start()