package com.ui
{	
	import com.events.MenuButtonPressed;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class MenuButton extends Sprite
	{
		private var graphics:Image;
		private var buttonName:String;
		
		public function MenuButton(xPos:Number, yPos:Number, name:String, sprite:Image)
		{
			super();
			this.x = xPos;
			this.y = yPos;
			this.alignPivot();
			
			buttonName = name;
			graphics = sprite;
			graphics.alignPivot();
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
			//If tapped or clicked
			if (touchDown){
				dispatchEvent(new MenuButtonPressed(MenuButtonPressed.PRESSED, buttonName, true));
				trace(buttonName + " Button Pressed");
			}
		}
	}
}