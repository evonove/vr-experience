"""
script used to interact with our platform
"""
extends KinematicBody

var vel = Vector3()
var force = 4*10
var pos = Vector3(0,1,0)

var is_platform_moving = false
var platform_moved = false

var timer = Timer.new()
onready var area_mesh_instance = get_node("Area/MeshInstance")

var upperFloor 
var stopping
var h

onready var player = get_node("../Player")

const SERCOMM = preload("res://addons/GDSerCommDock/bin/GDSerComm.gdns")
onready var PORT = SERCOMM.new()

enum  bytesz {
	SER_BYTESZ_8 = 0,
	SER_BYTESZ_7,
	SER_BYTESZ_6,
	SER_BYTESZ_5
}

# parity, to be used with open function (argument #5) and is optional
enum parity {
	SER_PAR_NONE,
	SER_PAR_ODD,
	SER_PAR_EVEN,
	SER_PAR_MARK,
	SER_PAR_SPACE
}

# stopbyte, to be used with open function (argument #6) and is optional
enum stopbyte {
	SER_STOPB_ONE, #1
	SER_STOPB_ONE5,#1.5
	SER_STOPB_TWO #2
} 

# queue, to be used with flush function 
# if not added, the function defaults to SER_QUEUE_IN
enum queue {
	SER_QUEUE_IN,
	SER_QUEUE_OUT,
	SER_QUEUE_ALL
}

func timer_setup():
	"""
	setup a timer used to make the platform to blink
	"""
	timer.set_autostart(true)
	timer.set_wait_time(2)
	# manually add timer to the tree
	add_child(timer)
	
	
func _on_timer_timeout():
	if not platform_moved:
		# makes the platform blink
		area_mesh_instance.visible = !area_mesh_instance.visible
	
	
   
func _ready():
	timer.connect("timeout", self, "_on_timer_timeout")
	timer_setup()
	upperFloor = get_node("../Environment/UpperFloor1")
	stopping = int(upperFloor.get_translation().y)
	print("ports", PORT.list_ports())
	var ports = PORT.list_ports();
	PORT.open(ports[0], 9600, 1000)
	PORT.flush()
	print("get_available", PORT.get_available())
   
func _move_platform_with_button():
	 timer.stop()
	 player.set_translation(Vector3(0.5,0,0.35))
	 is_platform_moving = true
	 platform_moved = true
	 area_mesh_instance.visible = false
	 PORT.write("h")
	 PORT.flush()
	
func _physics_process(delta):  
	if is_platform_moving:
		# makes the platform move
		vel.y = force * delta
		move_and_slide(vel, pos)
		h = int(self.get_translation().y)
		# platform stops
		if h == stopping:
			force = 0
			PORT.write("l")
			PORT.flush()