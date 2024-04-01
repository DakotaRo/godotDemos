extends Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_object_local(Vector3.RIGHT, -event.relative.y * 0.001)
