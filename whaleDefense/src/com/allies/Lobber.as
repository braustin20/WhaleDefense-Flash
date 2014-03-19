package com.allies
{
	import com.game.Enemy;
	import com.game.EnemySpawner;
	import com.game.Game;
	import com.projectiles.PlayerBasicProjectile;
	import com.greensock.TimelineMax;
	import com.greensock.easing.Linear;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.utils.Timer;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	public class Lobber extends GenericAlly
	{
		private var graphics:Image;
		private var newPlayerProjectile:PlayerBasicProjectile;
		
		//Reload time in ms
		private var reloadTime:Number = 5000;
		private var isReloaded:Boolean = true;
		private var timer:Timer;
		
		//The sprites used for this object
		private var assets:AssetManager;
		
		//Speed of the bullet
		public var velocity:Number = 4000;
		
		//We need a reference to the spawner to search for targets
		private var enemySpawner:EnemySpawner;
		
		private var launchSound:Sound;
		
		private var mainGame:Game;
				
		public function Lobber(xPos:Number, yPos:Number, game:Game, spawner:EnemySpawner)
		{
			this.x = xPos;
			this.y = yPos;
			
			assets = game.assets;
			mainGame = game;

			enemySpawner = spawner;
			
			launchSound = assets.getSound("woosh");
			
			//Load the catapault sprite
			var cannonTexture:Texture = assets.getTexture("Lobber");
			var cannonImage:Image = new Image(cannonTexture);
			
			graphics = cannonImage;
			
			//Move the sprite so that it's centered
			graphics.x -= graphics.width/2;
			graphics.y -= graphics.height/2;
			addChild(graphics);
			this.scaleX = .7;
			this.scaleY = .7;
			
			//Set the auto-reloader to a pre-determined reload time
			timer = new Timer(reloadTime, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onReloadComplete);
			timer.start();
			
			//Add listener which waits for stage creation
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		//Once the stage is created, add the remaining listeners
		public function onAddedToStage(event:Event):void{		
			
			
			//Remove the uneeded stage creation listener
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onReloadComplete(event:TimerEvent):void{
			//If there are enemies present, search through them
			if(enemySpawner.enemiesList.length >= 1 && !paused){
				//Store currently targeted enemy
				var targEnemy:Enemy;
				//The distance to the closest enemy
				var smallestDist:Number = 0;
				//For each present enemy, determine which is closest
				for each(var curEnemy:Enemy in enemySpawner.enemiesList){
					//Do the distance calculation with global coordinates
					var dist:Number = distanceBetween(globalToLocal(new Point(curEnemy.x, curEnemy.y)));
					//If the distance is the lowest so far, or this is the first one (0) then assign targeted enemy
					if((dist < smallestDist || smallestDist == 0)){
						//Make sure the enemy isn't invulnerable
						if(curEnemy.canDamage && (curEnemy.x > 0 && curEnemy.y > 0)){
							smallestDist = dist;
							targEnemy = curEnemy;
						}
					}
				}
				if(targEnemy != null){
					//Now that we have our target, grab it's coordinates
					var enemyLoc:Point = new Point(targEnemy.x, targEnemy.y);
				
					//Shoot a bullet at the specified coordinates
					shootBullet(enemyLoc);
					launchSound.play(0, 0, mainGame.effectsTransform);
				}
			}
			timer.start();
		}
		public function shootBullet(targLoc:Point):void{
			//Convert the global enemy coordinates to the coordinates of this lobber
			targLoc = globalToLocal(targLoc);

			//Load a new image for the projectile on each shot
			var projTexture:Texture = assets.getTexture("rockSm");
	//		var projImage:Image = new Image(projTexture);
			
			//Add a newPlayerProjectile relative to this cannon
			newPlayerProjectile = new PlayerBasicProjectile(0, 0, projTexture);
			
			addChild(newPlayerProjectile);
			
			//Create a timeline to hold the animations
			var timeline:TimelineMax = new TimelineMax();
			//Find the midpoint between the current position and target
			var midPoint:Object = findMid(new Point(newPlayerProjectile.x, newPlayerProjectile.y), targLoc);
			//Add a tween which scales up and moves to the mid point
			timeline.to(newPlayerProjectile, velocityToDuration(new Point(midPoint.x, midPoint.y), newPlayerProjectile), {x:midPoint.x, y:midPoint.y, scaleX:2, scaleY:2, ease:Linear.easeNone});
			//Add a tween directly afterwards which scales down and ends at the target
			timeline.to(newPlayerProjectile, velocityToDuration(targLoc, newPlayerProjectile), {x:targLoc.x, y:targLoc.y, scaleX:0.8, scaleY:0.8, ease:Linear.easeInOut, onComplete:newPlayerProjectile.destroy, onCompleteParams:[true]});
			
		}
		
		private function distanceBetween(p2:Point):Number{
			var duration:Number;
			var p1:Point = new Point(this.x, this.y);
			
			var distance:Number = Point.distance(p1, p2);
			
			return distance;
		}
		//Calculates duration in seconds from a given speed
		private function velocityToDuration(p2:Point, proj:PlayerBasicProjectile):Number{
			var duration:Number;
			var p1:Point = new Point(proj.x, proj.y);
			
			var distance:Number = Point.distance(p1, p2);
			
			duration = Math.abs(distance/velocity);
			return duration;
		}
		//Returns an object with an x and y property describing the middle of the two points passed in
		private function findMid(p1:Point, p2:Point):Object{
			return {x:p1.x + (p2.x - p1.x)/2, y:p1.y + (p2.y - p1.y)/2};
		}
	}
}