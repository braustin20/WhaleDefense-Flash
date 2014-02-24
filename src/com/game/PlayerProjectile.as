package com.game
{
	
	import starling.display.Quad;
	import starling.utils.Color;
	
	public class PlayerProjectile extends GenericProjectile
	{
		public function PlayerProjectile(xPos, yPos)
		{
			this.x = xPos;
			this.y = yPos;
			
			
			//Placeholder sprite
			graphics = new Quad(20, 20, Color.BLUE);
			//Move the sprite so that it's centered
			graphics.x -= graphics.width/2;
			graphics.y -= graphics.height/2;
			addChild(graphics);
			
		}
	}
}