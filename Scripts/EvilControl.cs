using Godot;
using System;

public partial class EvilControl : CharacterBody2D
{
    public const float Speed = 400.0f;

    private AnimatedSprite2D _evilSprite;
    public override void _Ready()
	{
        _evilSprite = GetNode<AnimatedSprite2D>("AnimationSprite");
    }

    public override void _PhysicsProcess(double delta)
    {
        _UpdateSpriteRenderer();

    }

    private void _UpdateSpriteRenderer()
    {        
        _evilSprite.Play("evilSprite");
    }
}
