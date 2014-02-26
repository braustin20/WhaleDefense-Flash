package com.game
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.Color;
	
	public class Base extends Sprite
	{
		private var graphics:Quad;
		public var health:Number;
		
		public function Base(xPos:Number, yPos:Number)
		{
			this.x = xPos;
			this.y = yPos;	
			
			//Basic health value
			this.health = 100;
			
			//Placeholder sprite
			graphics = new Quad(40, 40, Color.GREEN);
			//Move the sprite so that it's centered
			graphics.x -= graphics.width/2;
			graphics.y -= graphics.height/2;
			addChild(graphics);
		}
		//Called from an outside class to do damage to this base
		public function dealDamage(dmg:Number):void{
			this.health -= dmg
			
			if(health <= 0){
				destroy();
			}
		}
		public function destroy():void{
			this.removeFromParent(true);
			super.dispose();
			trace("You Lose");
		}
	}
}