package com.game
{
	import com.events.ProjectileHit;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class GenericProjectile extends Sprite
	{
		public var graphics:Quad;
		
		public function GenericProjectile(xPos:Number=NaN, yPos:Number=NaN)
		{
			this.x = xPos;
			this.y = yPos;
		}
		//Destroys this projectile and call the hit event
		public function destroy(isPlayer:Boolean=false):void{
			//Dispatch the event and denote who was the shooter
			dispatchEvent(new ProjectileHit(ProjectileHit.HIT, isPlayer, this, true));
			//Destruction
			this.removeFromParent(true);
		}
	}
}