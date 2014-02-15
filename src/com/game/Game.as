package com.game{
	import flash.geom.Point;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.Color;
	
	public class Game extends Sprite{
		
		private var newCannon:Cannon;
		private var selectedCannon:Cannon;
		
		//Placeholder
		private var background:Quad;
		
		public function Game(){
			//Flat color placeholder background
			background = new Quad(1280, 720, Color.GRAY);
			addChild(background);
			
			//Create a new cannon
			newCannon = new Cannon();
			addChild(newCannon);
			
			//Set the last created cannon as the current selected 
			//replace this later with mouse selection
			selectedCannon = newCannon;
			
			//Add listener which waits for stage creation
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		//Once the stage is created, add the remaining listeners
		public function onAddedToStage(event:Event):void{
			//Input listeners
			//Add listener for any touch/mouse event
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			
			//Remove the uneeded stage creation listener
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onTouch(event:TouchEvent):void{
			
			//Touch data when clicked or tapped down
			var touchDown:Touch = event.getTouch(this, TouchPhase.BEGAN);
			//If tapped or clicked, test fire the current cannon at the cursor location
			if (touchDown){
				var touchLoc:Point = touchDown.getLocation(selectedCannon);
				selectedCannon.shootBullet(touchLoc);
			}
		}
	}
}