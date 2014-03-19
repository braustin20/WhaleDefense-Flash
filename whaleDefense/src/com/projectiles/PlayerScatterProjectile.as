package com.projectiles
{
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class PlayerScatterProjectile extends GenericProjectile
	{
		
		public function PlayerScatterProjectile(xPos, yPos, sprite:Texture)
		{
			this.x = xPos;
			this.y = yPos;
			this.alignPivot();
			
			this.type = "Scatter";
			this.damage = 25;
			
			//Placeholder sprite
			graphics = new Image(sprite);
			//Move the sprite so that it's centered
			graphics.alignPivot();
			addChild(graphics);
			
		}
	}
}