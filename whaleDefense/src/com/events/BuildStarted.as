package com.events
{
	
	import com.allies.BuildZone;
	
	import starling.events.Event;
	
	public class BuildStarted extends Event
	{
		public static const BUILD:String = "buildStarted";
		
		private var bZone:BuildZone;
		
		//Constructor that stores data which can be passed on later
		public function BuildStarted(type:String, zone:BuildZone,bubbles:Boolean=false)
		{
			super(type, bubbles);
			bZone = zone;
			
		}
		public function get buildZone():BuildZone{
			return bZone;
		}
	}
}