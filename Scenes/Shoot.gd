extends Marker2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const BULLET = preload("res://Bullet.tscn")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	
	if Input.is_action_just_pressed("clicker left"):
		var bullet = BULLET.instantiate()
		bullet.position = get_parent().global_position
		get_parent().get_parent().add_child(bullet)
