extends MeshInstance3D


func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"): position.z -= 1 * delta * 5
	elif Input.is_action_pressed("ui_down"): position.z += 1 * delta * 5
	elif Input.is_action_pressed("ui_left"): position.x -= 1 * delta * 5
	elif Input.is_action_pressed("ui_right"): position.x += 1 * delta * 5
