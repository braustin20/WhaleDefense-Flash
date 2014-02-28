package com.levels
{
	import com.events.ProjectileFired;
	import com.events.ProjectileHit;
	import com.game.Base;
	import com.game.Cannon;
	import com.game.Enemy;
	import com.game.EnemySpawner;
	import com.game.GenericProjectile;
	import com.game.Ocean;
	import com.game.Shore;
	import com.greensock.motionPaths.LinePath2D;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.Color;
	
	public class Level1 extends Sprite
	{
		public var levelBase:Base;
		
		private var newCannon:Cannon;
		public var selectedCannon:Cannon;
		
		private var shoreList:Array;
		private var newShore:Shore;
		private var newPath:Array;
		public var pathArray:Array;
		
		private var isSpawning:Boolean;
		
		public var enemySpawner:EnemySpawner;
		
		//Placeholder
		private var background:Quad;
		
		private var ocean:Ocean;
		
		public function Level1(width:Number, height:Number)
		{
			//Flat color placeholder background
			background = new Quad(width, height, Color.GRAY);
			addChild(background);
			
			ocean = new Ocean();
			addChild(ocean);
			
			
			//Add the base that the player has to defend
			levelBase = new Base(600, 50);
			addChild(levelBase);
			
			
			//Create a list of landing zones
			shoreList = new Array();
			//Spawn some shores
			newShore = new Shore(600, 200);
			addChild(newShore);
			shoreList.push(newShore);
			
			
			
			//Add listener which waits for stage creation
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			
			//Create the enemy spawner
			enemySpawner = new EnemySpawner(shoreList, generatePaths(), levelBase);
			addChild(enemySpawner);
			
			//Create a new cannon
			newCannon = new Cannon(300, 50);
			addChild(newCannon);
			
			//Set the last created cannon as the current selected 
			//replace this later with mouse selection
			selectedCannon = newCannon;
			
		}
		//Called each frame
		public function onUpdate():void{
			if(enemySpawner.enemiesList.length < 20 && !isSpawning){
				isSpawning = true;
				var spawnTimer:Timer = new Timer(750, 1);
				spawnTimer.addEventListener(TimerEvent.TIMER, timedSpawn);
				spawnTimer.start();
			}
		}
		//Tell the enemy spawner to spawn a single enemy
		public function timedSpawn(event:TimerEvent):void{
			isSpawning = false;
			enemySpawner.createEnemy();
		}
		//May want to condense
		public function generatePaths():Array{
			pathArray = new Array();
			
			//Make your paths here, the more the better.
			newPath = new Array({x:100, y:750},
				{x:200, y:500},
				{x:shores[0].x, y:shores[0].y});
			pathArray.push(newPath);
			
			newPath = new Array({x:1100, y:750},
				{x:1000, y:500},
				{x:shores[0].x, y:shores[0].y});
			pathArray.push(newPath);
/*
			newPath = new Array([new Point(400, 700),
				new Point(400, 400),
				new Point(500, 360),
				new Point(shores[0].x, shores[0].y)]);
			pathArray.push(newPath);
			
			newPath = new Array([new Point(500, 700),
				new Point(240, 420),
				new Point(300, 310),
				new Point(shores[0].x, shores[0].y)]);
			pathArray.push(newPath);
			
			newPath = new Array([new Point(1000, 700),
				new Point(840, 420),
				new Point(900, 310),
				new Point(shores[0].x, shores[0].y)]);
			pathArray.push(newPath);
			
			newPath = new Array([new Point(100, 700),
				new Point(200, 400),
				new Point(400, 300),
				new Point(shores[1].x, shores[1].y)]);
			pathArray.push(newPath);
			
			newPath = new Array([new Point(400, 700),
				new Point(400, 400),
				new Point(500, 360),
				new Point(shores[1].x, shores[1].y)]);
			pathArray.push(newPath);
			
			newPath = new Array([new Point(500, 700),
				new Point(240, 420),
				new Point(300, 310),
				new Point(shores[1].x, shores[1].y)]);
			pathArray.push(newPath);
			
			newPath = new Array([new Point(1000, 700),
				new Point(840, 420),
				new Point(900, 310),
				new Point(shores[1].x, shores[1].y)]);
			pathArray.push(newPath);
			*/
			return pathArray;
		}
		
		//Once the stage is created, add the remaining listeners
		public function onAddedToStage(event:Event):void{		
			//Add player projectile hit listener
			stage.addEventListener(ProjectileHit.HIT, onProjectileHit);
			
			//Add player projectile fire listener
			stage.addEventListener(ProjectileFired.FIRED, onProjectileFired);
			
			//Used for game loop
			stage.addEventListener(Event.ENTER_FRAME, this.onUpdate);
			
			//Remove the uneeded stage creation listener
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		//Called when a shot has been fired into an object which accepts shots
		private function onProjectileFired(event:ProjectileFired):void{
			var touchLoc:Point = event.touch.getLocation(selectedCannon);
			
			selectedCannon.shootBullet(touchLoc);
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
						//Check to see if it has reached the shore or not yet
						if(enemy.canDamage){
							
							//Set the enemy to dead, so that they don't make a path to the base
							enemy.isDead = true;
							
							//Find it's index and remove it from the array of enemies
							var enemyIndex:Number = enemySpawner.enemiesList.indexOf(enemy);
							enemySpawner.enemiesList.splice(enemyIndex, 1);
							
							//Remove the tween this enemy is attached to
						//	enemySpawner.enemyPaths[enemy.targetPath].removeFollower(enemy.attachedFollower);
							
							//Destroy the enemy
							enemy.destroy();
						}
					}
				}
			}
		}
		public function get shores():Array{
			return this.shoreList;
		}
	}
}