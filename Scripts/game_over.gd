extends CanvasLayer

func _on_you_died_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")


func _on_timer_timeout():
	_on_you_died_pressed()
