extends CharacterBody2D

const SPEED = 300.0
var player_ref # Ссылка на узел игрока
var _evilSprite : AnimatedSprite2D
var direction = -1

func _ready():
	velocity = Vector2.ZERO
	_evilSprite = $AnimationSprite
	player_ref = get_node("../Hero")

func _physics_process(delta: float):
	if player_ref:
		var player_position = player_ref.global_position
		if player_position.x > global_position.x:
			direction = 1
		else:
			direction = -1
		velocity.x = direction * SPEED
		_update_sprite_renderer()
		move_and_slide()

func _update_sprite_renderer():
	_evilSprite.play("evilSprite")
