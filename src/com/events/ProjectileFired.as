package com.events
{
	
	import starling.events.Event;
	import starling.events.Touch;
	
	public class ProjectileFired extends Event
	{
		public static const FIRED:String = "projectileFired";
		
		//The values that we want to pass through with this Event
		private var isPlayerProj:Boolean;
		private var touchData:Touch;
		
		//Constructor that stores data which can be passed on later
		public function ProjectileFired(type:String, t:Touch, player:Boolean=false, bubbles:Boolean=false)
		{
			super(type, bubbles);
			isPlayerProj = player;
			touchData = t;
			
		}
		//Getter methods used when passing data to the EventListener
		public function get isPlayer():Boolean{
			return isPlayerProj;
		}
		public function get touch():Touch{
			return touchData;
		}
	}
}