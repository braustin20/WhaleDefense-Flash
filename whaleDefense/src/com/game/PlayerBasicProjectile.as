package com.game
{
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class PlayerBasicProjectile extends GenericProjectile
	{
		
		public function PlayerBasicProjectile(xPos, yPos, sprite:Texture)
		{
			this.x = xPos;
			this.y = yPos;
			this.alignPivot();
			
			this.type = "Basic";
			
			
			
			//Placeholder sprite
			graphics = new Image(sprite);
			//Move the sprite so that it's centered
			graphics.alignPivot();
			graphics.x = this.x;
			graphics.y = this.y;
			addChild(graphics);
			
		}
	}
}