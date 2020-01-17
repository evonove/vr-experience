"""
script used to interact with our platform
"""
extends KinematicBody

var vel = Vector3()
var force = 9.81*10
var pos = Vector3(0,1,0)

var is_platform_moving = false
var platform_moved = false

var timer = Timer.new()
onready var area_mesh_instance = get_node("Area/MeshInstance")


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
    
    
func _on_Area_body_entered(body):
	print("body name", body.get_name())
	if body.get_name() == "Player" and not platform_moved:
        timer.stop()
        is_platform_moving = true
        platform_moved = true
        area_mesh_instance.visible = false
        
	elif body.get_name() == "UpperFloor1":
        is_platform_moving = false
	
    
func _ready():
    timer.connect("timeout", self, "_on_timer_timeout")
    timer_setup()
    
    
func _physics_process(delta):            
    if is_platform_moving:
        # makes the platform move
        vel.y = force * delta
        move_and_slide(vel, pos)