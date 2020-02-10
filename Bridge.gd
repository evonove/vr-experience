extends Spatial

var timer = Timer.new()
onready var player = get_node("../Player")

func timer_setup():
	timer.set_autostart(false)
	timer.set_wait_time(2)
	timer.process_mode = 0
	add_child(timer)

func _on_timer_timeout():
	$Boards.apply_torque_impulse(Vector3(0.009,0,0))

func _ready():
	timer.connect("timeout", self, "_on_timer_timeout")
	timer_setup()

func _on_Board1_area_entered(area):
#	pass
	if area.get_name() == "RightFootArea" or area.get_name() == "LeftFootArea":
		print("Player is on the Board1")
		timer.start()

func _on_Board7_area_exited(area):
#	pass
	if area.get_name() == "RightFootArea" or area.get_name() == "LeftFootArea":
		timer.stop()

