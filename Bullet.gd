extends Area2D

const SPEED = 500
var velocity = Vector2()
@export var direction = 1

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	if(direction == -1):
		$Sprite2D.flip_h = true
	translate(velocity)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int):
	if body.is_in_group("evil"):
		queue_free()
		body.queue_free()


