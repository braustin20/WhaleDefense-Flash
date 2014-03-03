package com.game
{
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Base extends Sprite
	{
		private var graphics:Image;
		public var health:Number;
		
		public function Base(xPos:Number, yPos:Number, sprite:Image)
		{
			this.x = xPos;
			this.y = yPos;	
			
			//Basic health value
			this.health = 100;
			
			//Placeholder sprite
			graphics = sprite;
			//Move the sprite so that it's centered
			graphics.alignPivot();
			graphics.scaleX = .8;
			graphics.scaleY = .8;
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