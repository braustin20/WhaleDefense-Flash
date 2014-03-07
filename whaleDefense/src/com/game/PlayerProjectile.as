package com.game
{
	import starling.display.Image;
	
	public class PlayerProjectile extends GenericProjectile
	{
		public function PlayerProjectile(xPos, yPos, sprite:Image)
		{
			this.x = xPos;
			this.y = yPos;
			this.alignPivot();
			
			//Placeholder sprite
			graphics = sprite;
			//Move the sprite so that it's centered
			graphics.alignPivot();
			graphics.x = this.x;
			graphics.y = this.y;
			addChild(graphics);
			
		}
	}
}