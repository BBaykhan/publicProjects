using Godot;
using System;

public partial class Player : Sprite2D // Now extending Sprite2D
{
	private float speed = 200.0f;

	public override void _Process(double delta)
	{	
		Vector2 velocity = Vector2.Zero;

		if (Input.IsActionPressed("ui_up"))
			velocity.Y -= 1;
		if (Input.IsActionPressed("ui_down"))
			velocity.Y += 1;
		if (Input.IsActionPressed("ui_left"))
			velocity.X -= 1;
		if (Input.IsActionPressed("ui_right"))
			velocity.X += 1;

		if (velocity != Vector2.Zero)
			velocity = velocity.Normalized() * speed * (float)delta;
		
		Position += velocity;
		GD.Print($"Position: {Position}");
	}
}
