package com.levels
{
	import com.events.ProjectileHit;
	import com.game.Cannon;
	import com.game.Enemy;
	import com.game.EnemySpawner;
	import com.game.GenericProjectile;
	
	import flash.geom.Point;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.Color;
	
	public class Level1 extends Sprite
	{
		private var newCannon:Cannon;
		public var selectedCannon:Cannon;
		
		public var enemySpawner:EnemySpawner;
		
		//Placeholder
		private var background:Quad;
		
		public function Level1(width:Number, height:Number)
		{
			//Flat color placeholder background
			background = new Quad(width, height, Color.GRAY);
			addChild(background);
			
			//Create a new cannon
			newCannon = new Cannon();
			addChild(newCannon);
			
			//Create the enemy spawner
			enemySpawner = new EnemySpawner();
			addChild(enemySpawner);
			
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
			this.addEventListener(TouchEvent.TOUCH, onTouch);
			
			//Add player projectile hit listener
			stage.addEventListener(ProjectileHit.HIT, onProjectileHit);
			
			//Remove the uneeded stage creation listener
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		//This is typically called when a player bullet finishes it's animation
		public function onProjectileHit(event:ProjectileHit):void{
			//Store the projectile passed through from the event
			var tempProjectile:GenericProjectile = event.projectile;
			
			//If the object which triggered this was a player cannon, try to destroy an enemy
			if(event.isPlayer){
				//Search through the list of enemies to see if we just hit one
				for each (var enemy:Enemy in enemySpawner.enemiesList){
					//If the sprites intersect, destroy the ship
					if(tempProjectile.getBounds(stage).intersects(enemy.getBounds(stage))){
						enemy.destroy();
						
						//After the enemy has been destroyed, find it's index and remove it from the array of enemies
						var enemyIndex:Number = enemySpawner.enemiesList.indexOf(enemy);
						enemySpawner.enemiesList.splice(enemyIndex, 1);
					}
				}
			}
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