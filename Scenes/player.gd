extends CharacterBody2D

class_name Player

const SPEED = 400.0
const JUMP_VELOCITY = 800.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var maxHealth = 100
@export var currentHealth: int = maxHealth
var shake

var time = 0
@onready var _heroSprite: AnimatedSprite2D = $AnimationSprite

func _ready():
	shake = false
	
func controller(delta):
	var vel = velocity
	
	if (!is_on_floor()):
		vel.y += gravity * delta
		
	if (Input.is_action_just_pressed("space") && is_on_floor()):
		vel.y = -JUMP_VELOCITY
	
	vel.x = 0
	if (Input.is_action_pressed("right")):
		vel.x = SPEED
	elif (Input.is_action_pressed("left")):
		vel.x = -SPEED
		
	
	velocity = vel
		
	updateSpriteRenderer(vel.x,vel.y)	
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
	
		
func _physics_process(delta):
	controller(delta)
	shaker()
	

func take_damage(damage_amount):
	_heroSprite.use_parent_material = false
	currentHealth -= damage_amount 
	shake = true
	$AnimationPlayer.play("Damage_animation")
	if currentHealth <= 0:
		on_death()
	

func shaker():
	if shake:
		time += 1
		var final_pos = Vector2(sin(time)*10,sin(time)*20)	
		$Camera2D.offset = lerp($Camera2D.offset, final_pos, 0.2)
	elif time:
		time = 0
	

func on_death():
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
