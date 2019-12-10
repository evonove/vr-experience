extends Spatial

func _ready():
	var interface = ARVRServer.find_interface("OpenVR")
	if interface and interface.initialize():
		# turn to ARVR mode
		get_viewport().arvr = true
	
		# keep linear color space, not needed with the GLES2 renderer
		get_viewport().keep_3d_linear = true
	
		# make sure vsync is disabled or we'll be limited to 60fps
		OS.vsync_enabled = false
		
		# up our physics to 90fps to get in sync with our rendering
		Engine.target_fps = 90