package com.events
{	
	import com.game.GenericProjectile;
	
	import starling.events.Event;
	
	public class ProjectileHit extends Event
	{
		public static const HIT:String = "projectileHit";
		
		//The values that we want to pass through with this Event
		private var hitProjectile:GenericProjectile;
		private var isPlayerProj:String;
		
		//Constructor that stores data which can be passed on later
		public function ProjectileHit(type:String, player:String="Generic", proj:GenericProjectile=null, bubbles:Boolean=false)
		{
			super(type, bubbles);
			hitProjectile = proj;
			isPlayerProj = player;
			
		}
		//Getter methods used when passing data to the EventListener
		public function get projectile():GenericProjectile{
			return hitProjectile;
		}
		public function get isPlayer():String{
			return isPlayerProj;
		}
	}
}