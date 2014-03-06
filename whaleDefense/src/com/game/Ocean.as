package com.game
{
	import com.events.ProjectileFired;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Ocean extends Sprite
	{
		public var graphics:Image;
		
		public function Ocean(sprite:Image)
		{
			this.x = 0;
			this.y = 0;
			
			
			//Placeholder sprite
			graphics = sprite;
			
			addChild(graphics);
			
			//Add listener which waits for stage creation
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage():void{
			//Input listeners
			//Add listener for any touch/mouse event
			this.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		public function onTouch(event:TouchEvent):void{
			//Touch data when clicked or tapped down
			var touchDown:Touch = event.getTouch(this, TouchPhase.ENDED);
			
			//If tapped or clicked, test fire the current cannon at the cursor location
			if (touchDown){
				//Dispatch the event and denote who was the shooter
				dispatchEvent(new ProjectileFired(ProjectileFired.FIRED, touchDown, true, true));
			}
		}
	}
}