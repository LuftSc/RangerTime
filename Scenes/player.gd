extends CharacterBody2D

class_name Player

const SPEED = 400.0
const JUMP_VELOCITY = 800.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var maxHealth = 100
@export var currentHealth: int = maxHealth
@export var isTimeStopped = false
var _heroSprite: AnimatedSprite2D

func _ready():
	_heroSprite = $AnimationSprite
	
func controller(delta):
	var vel = velocity
	
	if (!is_on_floor()):
		vel.y += gravity * delta
		
	if (Input.is_action_just_pressed("space") && is_on_floor()):
		vel.y = -JUMP_VELOCITY
	
	vel.x = 0
	if (Input.is_action_pressed("right")):
		vel.x = SPEED
	if (Input.is_action_pressed("left")):
		vel.x = -SPEED
	if Input.is_action_just_pressed("clicker right"):
		if isTimeStopped != true:
			isTimeStopped = true
		else:
			isTimeStopped = false
		
	updateSpriteRenderer(vel.x,vel.y)
	
	velocity = vel
	move_and_slide()
	
func updateSpriteRenderer(velX:float,velY:float):
	var running = velX != 0
	var jumping = velY != 0
	
	if (running && !jumping):
		_heroSprite.play("Run")
		_heroSprite.flip_h = velX < 0
	elif (jumping):
		_heroSprite.play("JumpUp")
		_heroSprite.flip_h = velX < 0
		_heroSprite.stop()
	else:
		_heroSprite.play("Idle")
				
func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if (collider.name == "Evil"):
			currentHealth -= 5
			if currentHealth <= 0:
				on_death()
		
func _physics_process(delta):
	controller(delta)
	handleCollision()
	

func on_death():
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
