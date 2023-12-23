using Godot;
using System;

public partial class EvilControl : CharacterBody2D
{
	private Vector2 velocity;
	private float speed = 100; 

	private AnimatedSprite2D _evilSprite;

	private float distanceMoved = 0; 
	private float maxDistance = 50000; 

	private bool movingRight = true; 

	public override void _Ready()
	{
		_evilSprite = GetNode<AnimatedSprite2D>("AnimationSprite");
	}

	public override void _PhysicsProcess(double delta)
	{        
		if (distanceMoved >= maxDistance)
		{            
			movingRight = !movingRight;
			distanceMoved = 0;
		}

		float direction = movingRight ? -100 : 100;
		velocity.X = speed * direction;

		_UpdateSpriteRenderer();
		Velocity = velocity * (float)delta;
		MoveAndSlide();

		distanceMoved += Mathf.Abs(velocity.X * (float)delta);
	}

	private void _UpdateSpriteRenderer()
	{
		_evilSprite.Play("evilSprite");
	}
}
