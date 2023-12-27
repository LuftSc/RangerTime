extends CanvasLayer

func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://Scenes/cosmic_ship.tscn")


func _on_about_authors_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit()
