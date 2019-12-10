extends Spatial

func _ready():
	var interface = ARVRServer.find_interface("OpenVR")
	if interface :
		interface.initialize()
		# make sure vsync is disabled or we'll be limited to 60fps
		OS.vsync_enabled = false
	
		# up our physics to 90fps to get in sync with our rendering
		Engine.target_fps = 90