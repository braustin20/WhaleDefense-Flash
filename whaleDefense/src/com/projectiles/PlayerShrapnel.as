package com.projectiles
{
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class PlayerShrapnel extends GenericProjectile
	{
		
		public function PlayerShrapnel(xPos, yPos, sprite:Texture)
		{
			this.x = xPos;
			this.y = yPos;
			this.alignPivot();
			
			this.type = "Shrapnel";
			this.damage = 50;
			
			
			//Placeholder sprite
			graphics = new Image(sprite);
			//Move the sprite so that it's centered
			graphics.alignPivot();
			addChild(graphics);
			
		}
	}
}