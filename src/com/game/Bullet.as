package com.game
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.Color;
	
	public class Bullet extends Sprite
	{
		private var graphics:Quad;
		
		public function Bullet(xPos, yPos)
		{
			this.x = xPos;
			this.y = yPos;
			
			graphics = new Quad(50, 50, Color.BLUE);
			//Move the sprite so that it's centered
			graphics.x = this.x - graphics.width/2;
			graphics.y = this.y - graphics.height/2;
			addChild(graphics);
			
		}
		public function destroy():void{
			this.removeFromParent(true);
		}
	}
}