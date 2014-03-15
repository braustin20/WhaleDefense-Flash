package com.game
{	
	import com.events.ProjectileFired;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.Color;
	
	public class Enemy extends Sprite
	{	
		public var graphics:MovieClip;
		public var hitBox:Quad;
		
		public var listIndex:Number;
		//A reference to the path this enemy is following
		public var targetPath:Number;
		public var speed:Number;
		
		public var damage:Number;
		public var health:Number = 100;
		public var value:Number = 100;
		
		public var canDamage:Boolean;
		public var isDead:Boolean;
	
		public function Enemy(xPos:Number, yPos:Number, spriteGraphics:MovieClip)
		{
			this.x = xPos;
			this.y = yPos;	
			
			this.alignPivot();
		
			//Set speed and damage hard coded for now
			speed = 100;
			damage = 20;
			
			//Add a box which detects collisions
			hitBox = new Quad(60, 110, Color.BLUE);
			hitBox.alignPivot();
			
			//Toggle this to see debug hitbox underneath sprite
			hitBox.visible = false;
			addChild(hitBox);
			
			
			//Placeholder sprite
			graphics = spriteGraphics;
			//Center the pivot
			graphics.alignPivot();
			
			graphics.scaleX = .35;
			graphics.scaleY = .35;
			addChild(graphics);
			
			graphics.loop = true;
			graphics.play();
			Starling.juggler.add(graphics);

			//Additional positioning of hitbox in case of weird graphic
			hitBox.x = graphics.x - 5;
			hitBox.y = graphics.y + 20;
			
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
			this.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		public function onTouch(event:TouchEvent):void{
			//Touch data when clicked or tapped down
			var touchDown:Touch = event.getTouch(this, TouchPhase.ENDED);
			//If tapped or clicked, test fire the current cannon at the cursor location
			if (touchDown && canDamage){
				//Dispatch the event and denote who was the shooter
				dispatchEvent(new ProjectileFired(ProjectileFired.FIRED, touchDown, true, true));
			}
		}
	}
}