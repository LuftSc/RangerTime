using Godot;

public partial class ControllerPlayer : CharacterBody2D
{
	public const float Speed = 400.0f;
	public const float JumpVelocity = 800.0f;	

	// Get the gravity from the project settings to be synced with RigidBody nodes.
	public float gravity = ProjectSettings.GetSetting("physics/2d/default_gravity").AsSingle();

	private AnimatedSprite2D _heroSprite;

    public override void _Ready()
    {
        _heroSprite = GetNode<AnimatedSprite2D>("AnimationSprite");		
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

		_UpdateSpriteRenderer(velocity.X, velocity.Y);

        Velocity = velocity;
		MoveAndSlide();
	}

	private void _UpdateSpriteRenderer(float velX, float velY)
	{
        bool running = velX != 0;
		bool jumping = velY != 0;

		if (running && !jumping)
		{
			_heroSprite.Play("Run");
            _heroSprite.FlipH = velX < 0;			
		}
		else if (jumping)
        {
			_heroSprite.Play("JumpUp");
			_heroSprite.FlipH = velX < 0;
			_heroSprite.Stop();		
        }
        else _heroSprite.Play("Idle");
    }


}
