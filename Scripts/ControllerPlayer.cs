using Godot;
using System;

public partial class ControllerPlayer : CharacterBody2D
{
	public const float Speed = 400.0f;
	public const float JumpVelocity = 800.0f;	

	// Get the gravity from the project settings to be synced with RigidBody nodes.
	public float gravity = ProjectSettings.GetSetting("physics/2d/default_gravity").AsSingle();

	private Sprite2D _idleSprite;
	private AnimatedSprite2D _runSprite;

    public override void _Ready()
    {		
		_idleSprite = GetNode<Sprite2D>("IdleSprite");
        _runSprite = GetNode<AnimatedSprite2D>("RunSprite");		
    }

    public override void _PhysicsProcess(double delta)
	{
		Vector2 velocity = Velocity;

		// Add the gravity.
		if (!IsOnFloor())
			velocity.Y += gravity * (float)delta;

		// Handle Jump.
		if (Input.IsKeyPressed(Key.Space) && IsOnFloor())
			velocity.Y = -JumpVelocity;

		// Get the input direction and handle the movement/deceleration.
		// As good practice, you should replace UI actions with custom gameplay actions.
		velocity.X = 0;
		if (Input.IsKeyPressed(Key.A))
		{
			velocity.X = -Speed;			
		}
		else if (Input.IsKeyPressed(Key.D))
		{
			velocity.X = Speed;            
        }

		_UpdateSpriteRenderer(velocity.X);

        Velocity = velocity;
		MoveAndSlide();
	}

	private void _UpdateSpriteRenderer(float velX)
	{
		bool running = velX != 0;
		_idleSprite.Visible = !running;
		_runSprite.Visible = running;

		if (running)
		{
			_runSprite.Play();
			_runSprite.FlipH = velX < 0;
		}
	}


}
