using Godot;
using System;

public partial class Bullet : Area2D
{
    public float Speed = 400;
    public Vector2 Direction;

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{        
    }
}
