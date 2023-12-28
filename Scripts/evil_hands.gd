extends Node2D
	
@onready var _evilHandSprite = $AnimatedSprite2D


func _process(delta):
	_evilHandSprite.play("animated")

func _on_area_2d_player_entered(body):
	if body.name == "Hero":
		body.currentHealth -= 50
		if body.currentHealth <= 0:
			body.on_death()



