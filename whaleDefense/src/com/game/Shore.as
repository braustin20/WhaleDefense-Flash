package com.game
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.Color;
	
	public class Shore extends Sprite
	{
		private var graphics:Quad;
		
		public function Shore(xPos:Number, yPos:Number)
		{
			this.x = xPos;
			this.y = yPos;
			
			//Placeholder sprite
			graphics = new Quad(40, 10, Color.NAVY);
			//Move the sprite so that it's centered
			graphics.x -= graphics.width/2;
			graphics.y -= graphics.height/2;
			addChild(graphics);
		}
	}
}