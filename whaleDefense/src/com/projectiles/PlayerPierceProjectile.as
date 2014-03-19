package com.projectiles
{
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class PlayerPierceProjectile extends GenericProjectile
	{
		
		public function PlayerPierceProjectile(xPos, yPos, sprite:Texture)
		{
			this.x = xPos;
			this.y = yPos;
			this.alignPivot();
			
			this.type = "Pierce";
			this.damage = 50;
			
			
			//Placeholder sprite
			graphics = new Image(sprite);
			//Move the sprite so that it's centered
			graphics.alignPivot();
			addChild(graphics);
			
		}
	}
}