package com.game
{	
	import com.events.ProjectileFired;
	import com.greensock.motionPaths.PathFollower;
	
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.Color;
	
	public class Enemy extends Sprite
	{
		public var graphics:Quad;
		public var listIndex:Number;
		//A reference to the path this enemy is following
		public var targetPath:Number;
		public var speed:Number;
		
		//The follower object which tracks motion paths
		public var attachedFollower:PathFollower;
		
		public var canDamage:Boolean;
		public var isDead:Boolean;
	
		public function Enemy(xPos:Number, yPos:Number)
		{
			this.x = xPos;
			this.y = yPos;	
			
			//Set speed hard coded for now
			speed = 100;
			
			//Placeholder sprite
			graphics = new Quad(30, 30, Color.YELLOW);
			//Move the sprite so that it's centered
			graphics.x -= graphics.width/2;
			graphics.y -= graphics.height/2;
			addChild(graphics);
			
			//Add listener which waits for stage creation
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		public function destroy():void{
			this.removeFromParent(true);
			super.dispose();
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
			if (touchDown && canDamage){
				//Dispatch the event and denote who was the shooter
				dispatchEvent(new ProjectileFired(ProjectileFired.FIRED, touchDown, true, true));
			}
		}
	}
}