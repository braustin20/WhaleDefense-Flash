package com.ui
{
	
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.Color;
	
	public class Slider extends Sprite
	{
		private var bar:Quad;
		private var handle:Quad;
		public var value:Number;
		
		private var maxDrag:Number;
		private var minDrag:Number;
		
		public function Slider(val:Number=1.0)
		{
			super();
			
			value = val;
			if(value > 1.0){
				value = 1.0;
			}
			
			
			
			bar = new Quad(150, 10, Color.BLACK);

			addChild(bar);
			
			
			
			handle = new Quad(15, 20, Color.GRAY);
			
			maxDrag = (bar.x + bar.width) - handle.width;
			minDrag = bar.x;
			
			handle.x = ((maxDrag - bar.x) * value) + bar.x;
			handle.y = this.y - (handle.height/2) + bar.height/2;
			addChild(handle);
			
			
			
			//Add listener which waits for stage creation
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		//Once the stage is created, add the remaining listeners
		public function onAddedToStage(event:Event):void{		
			this.addEventListener(TouchEvent.TOUCH, onTouch);
			
			//Remove the uneeded stage creation listener
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onTouch(event:TouchEvent):void{
			var touchDown:Touch = event.getTouch(this, TouchPhase.BEGAN);
			var touchMoved:Touch = event.getTouch(this, TouchPhase.MOVED);
			var touchEnded:Touch = event.getTouch(this, TouchPhase.ENDED);
			
			if(touchDown){
				if(touchDown.getLocation(this).x > maxDrag){
					handle.x = maxDrag;
				}
				else if(touchDown.getLocation(this).x < minDrag){
					handle.x = minDrag;
				}
				else{
					handle.x = touchDown.getLocation(this).x;
				}
			}
			else if(touchMoved){
				if(touchMoved.getLocation(this).x > maxDrag){
					handle.x = maxDrag;
				}
				else if(touchMoved.getLocation(this).x < minDrag){
					handle.x = minDrag;
				}
				else{
					handle.x = touchMoved.getLocation(this).x;
				}
			}
			else if(touchEnded){
				value = (handle.x - bar.x) / (maxDrag - bar.x);
			}
		}
	}
}