package com.game
{
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.Color;
	
	public class Base extends Sprite
	{
		private var graphics:Image;
		private var healthBarBack:Quad;
		private var healthBar:Quad;
		private var healthBarMaxSize:Number;
		
		public var health:Number;
		private var maxHealth:Number;
		
		public function Base(xPos:Number, yPos:Number, sprite:Image)
		{
			this.x = xPos;
			this.y = yPos;	
			
			//Basic health value
			this.health = 100;
			maxHealth = health;
			
			//Placeholder sprite
			graphics = sprite;
			//Move the sprite so that it's centered
			graphics.alignPivot();
			graphics.scaleX = .8;
			graphics.scaleY = .8;
			addChild(graphics);
			
			//The red background to the health bar
			healthBarBack = new Quad(75, 8, Color.RED);
			healthBarBack.y -= 60;
			healthBarBack.x -= healthBarBack.width/2;
			addChild(healthBarBack);
			
			//The green foreground
			healthBar = new Quad(75, 8, Color.GREEN);
			healthBarMaxSize = healthBar.width;
			healthBar.y -= 60;
			healthBar.x -= healthBar.width/2;
			addChild(healthBar);
			
			//Add listener which waits for stage creation
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		protected function onUpdate():void{
			
		}
		//Once the stage is created, add the remaining listeners
		public function onAddedToStage(event:Event):void{	
			//Used for game loop
			stage.addEventListener(Event.ENTER_FRAME, this.onUpdate);
		}
		//Called from an outside class to do damage to this base
		public function dealDamage(dmg:Number):void{
			this.health -= dmg
			
			if(health <= 0){
				destroy();
			}
			//Change the health bar
			healthBar.width *= health/maxHealth;
		}
		public function destroy():void{
			this.removeFromParent(true);
			super.dispose();
			trace("You Lose");
		}
	}
}