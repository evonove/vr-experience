extends StaticBody

signal move_platform

func _ready():
	pass # Replace with function body.

func _on_Area_area_entered(area):
	if area.get_name() == "LeftHandArea" or area.get_name() == "RightHandArea":
		$Area/MeshInstanceButtonPressed.visible = true
		$Area/MeshInstanceButton.visible = false
		$Pressed.play("Press")
		emit_signal("move_platform")
