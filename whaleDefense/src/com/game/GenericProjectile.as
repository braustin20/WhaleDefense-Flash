package com.game
{
	import com.events.ProjectileHit;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class GenericProjectile extends Sprite
	{
		public var graphics:Image;
		public var type:String = "Generic";
		public var damage:Number;
		
		public function GenericProjectile(xPos:Number=0, yPos:Number=0)
		{
			this.x = xPos;
			this.y = yPos;
			this.alignPivot();
			this.damage = 100;
		}
		//Destroys this projectile and call the hit event
		public function destroy(isPlayer:Boolean=false):void{
			//Dispatch the event and denote who was the shooter
			dispatchEvent(new ProjectileHit(ProjectileHit.HIT, this.type, this, true));
			//Destruction
			this.removeFromParent(true);
		}
	}
}