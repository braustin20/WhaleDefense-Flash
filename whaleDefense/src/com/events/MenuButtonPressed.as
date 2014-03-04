package com.events
{	
	import starling.events.Event;
	
	public class MenuButtonPressed extends Event
	{
		public static const PRESSED:String = "buttonPressed";
		
		private var bName:String;
		
		//Constructor that stores data which can be passed on later
		public function MenuButtonPressed(type:String, name:String,bubbles:Boolean=false)
		{
			super(type, bubbles);
			bName = name;
			
		}
		public function get buttonName():String{
			return bName;
		}
	}
}