package com.game
{
	import com.events.ProjectileFired;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.Color;
	
	public class Ocean extends Sprite
	{
		private var graphics:Quad;
		
		public function Ocean()
		{
			this.x = 0;
			this.y = 200;
			
			//Placeholder sprite
			graphics = new Quad(1280, 520, Color.TEAL);

			addChild(graphics);
			
			//Add listener which waits for stage creation
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage():void{
			//Input listeners
			//Add listener for any touch/mouse event
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		public function onTouch(event:TouchEvent):void{
			//Touch data when clicked or tapped down
			var touchDown:Touch = event.getTouch(this, TouchPhase.BEGAN);
			//If tapped or clicked, test fire the current cannon at the cursor location
			if (touchDown){
				//Dispatch the event and denote who was the shooter
				dispatchEvent(new ProjectileFired(ProjectileFired.FIRED, touchDown, true, true));
			}
		}
	}
}