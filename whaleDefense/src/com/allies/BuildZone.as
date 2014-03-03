package com.allies
{
	
	import com.events.BuildStarted;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class BuildZone extends Sprite
	{
		public var occupied:Boolean = false;
		private var graphics:Image;
		
		public function BuildZone(xPos:Number, yPos:Number, sprite:Image)
		{
			super();
			
			this.x = xPos;
			this.y = yPos;
			this.alignPivot();
				
			graphics = sprite;
			graphics.alignPivot();
			graphics.scaleX = .8;
			graphics.scaleY = .8;
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
			var touchDown:Touch = event.getTouch(this, TouchPhase.ENDED);
			//If tapped or clicked
			if (touchDown){
				//Dispatch the event
				dispatchEvent(new BuildStarted(BuildStarted.BUILD, this, true));
			}
		}
	}
}