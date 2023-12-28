extends CharacterBody2D

const SPEED = 300.0
var player_ref
var _evilSprite : AnimatedSprite2D
var evil_area : Area2D
var direction = -1
var attacking = false
var damage_timer = 0.0
var damage_interval = 0.3

func _ready():
	velocity = Vector2.ZERO
	_evilSprite = $AnimationSprite
	evil_area = $PlayerDetector
	player_ref = get_node("../Hero")
	damage_timer = damage_interval

func _physics_process(delta: float):
	if player_ref and !attacking:
		var player_position = player_ref.global_position
		if player_position.x > global_position.x:
			direction = 1
			_update_sprite_renderer("evilSprite", -direction)
			evil_area.rotate(180)
		else:
			direction = -1
			_update_sprite_renderer("evilSprite", -direction)
			
		velocity.x = direction * SPEED		
		move_and_slide()

	damage_timer -= delta
	if damage_timer <= 0 and attacking:        
		player_ref.take_damage(10)
		damage_timer = damage_interval

func _update_sprite_renderer(animation, dir):
	_evilSprite.play(animation)
	_evilSprite.flip_h = dir < 0

func _on_player_detector_body_entered(body):
	if body.name == "Hero":
		velocity.x = 0
		_update_sprite_renderer("evilSpriteAttack",-direction)
		attacking = true

func _on_player_detector_body_exited(body):
	if body.name == "Hero":
		attacking = false
