package com.game
{	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.Color;
	
	public class Enemy extends Sprite
	{
		public var graphics:Quad;
		public var listIndex:Number;
		public var targetShore:Shore;
		public var speed:Number;
	
		public function Enemy(xPos:Number, yPos:Number)
		{
			this.x = xPos;
			this.y = yPos;	
			
			//Set speed hard coded for now
			speed = 100;
			
			//Placeholder sprite
			graphics = new Quad(30, 30, Color.YELLOW);
			//Move the sprite so that it's centered
			graphics.x -= graphics.width/2;
			graphics.y -= graphics.height/2;
			addChild(graphics);
		}
		public function destroy():void{
			this.removeFromParent(true);
		}
	}
}