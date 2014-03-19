package com.ui
{
	import com.events.MenuButtonPressed;
	import com.game.Game;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class ProjectileSwapper extends Sprite
	{
		private var mainGame:Game;
		private var graphics:Image;
		
		public function ProjectileSwapper(xPos:Number, yPos:Number, game:Game)
		{
			super();
			this.x = xPos;
			this.y = yPos;
			this.alignPivot();
			mainGame = game;
			graphics = new Image(mainGame.assets.getTexture("projSwitcher"));
			graphics.alignPivot();
			addChild(graphics);
			this.y += graphics.height/2;
			
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
			var touchDown:Touch = event.getTouch(this, TouchPhase.BEGAN);
			//If tapped or clicked, test fire the current cannon at the cursor location
			if (touchDown){
				//Dispatch the event and denote who was the shooter
				dispatchEvent(new MenuButtonPressed(MenuButtonPressed.PRESSED, "Swapper", true));
			}
		}
	}
}