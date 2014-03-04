package com.levels
{
	import com.allies.BuildZone;
	import com.allies.Lobber;
	import com.events.BuildStarted;
	import com.events.ProjectileFired;
	import com.events.ProjectileHit;
	import com.game.Base;
	import com.game.Cannon;
	import com.game.Enemy;
	import com.game.EnemySpawner;
	import com.game.GenericProjectile;
	import com.game.Ocean;
	import com.game.Shore;
	import com.greensock.TweenMax;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.Color;
	
	public class Level1 extends Sprite
	{
		//Load sprite sheet files
		[Embed(source="../assets/level1.xml",mimeType="application/octet-stream")]
		private var LevelAnimData:Class;
		[Embed(source="../assets/level1.png")]
		private var LevelAnimTexture:Class;
		
		[Embed(source="../assets/playerObjects_basic.xml",mimeType="application/octet-stream")]
		private var ObjectsAnimData:Class;
		[Embed(source="../assets/playerObjects_basic.png")]
		private var ObjectsAnimTexture:Class;
		
		//The texture atlases used
		public var levelTextureAtlas:TextureAtlas;
		public var objectsTextureAtlas:TextureAtlas;
		
		public var levelBase:Base;
		
		private var newCannon:Cannon;
		public var selectedCannon:Cannon;
		
		public var buildZones:Array;
		
		private var shoreList:Array;
		private var newShore:Shore;
		private var newPath:Array;
		public var pathArray:Array;
		
		private var isSpawning:Boolean;
		
		private var textField:TextField;
		public var currency:Number = 0;
		
		public var paused:Boolean;
		
		public var enemySpawner:EnemySpawner;
		
		private var ocean:Ocean;
		
		public function Level1(sWidth:Number, sHeight:Number)
		{	
			//The texture atlas
			var levelTexture:Texture = Texture.fromBitmap(new LevelAnimTexture());
			var levelXmlData:XML = XML(new LevelAnimData());
			levelTextureAtlas = new TextureAtlas(levelTexture, levelXmlData);;
			
			var objectsTexture:Texture = Texture.fromBitmap(new ObjectsAnimTexture());
			var objectsXmlData:XML = XML(new ObjectsAnimData());
			objectsTextureAtlas = new TextureAtlas(objectsTexture, objectsXmlData);;
			
			var sandTexture:Texture = levelTextureAtlas.getTexture("Level1_sand");
			var sandImage:Image = new Image(sandTexture);
			sandImage.y = sHeight - sandImage.height;
			addChild(sandImage);
			
			var waterTexture:Texture = levelTextureAtlas.getTexture("Level1_water");
			var waterImage:Image = new Image(waterTexture);
			ocean = new Ocean(waterImage);
			addChild(ocean);
			
			var detailTexture:Texture = levelTextureAtlas.getTexture("Level1_detail");
			var detailImage:Image = new Image(detailTexture);
			detailImage.y = (sHeight - sandImage.height - 50);
			addChild(detailImage);
			
			//Add the base that the player has to defend
			var baseTexture:Texture = objectsTextureAtlas.getTexture("castleSm");
			var baseImage:Image = new Image(baseTexture);
			levelBase = new Base(sWidth/2, (sHeight - 95), baseImage);
			addChild(levelBase);
			
			//Create the areas where the player is able to build defenses
			buildZones = new Array();
			
			var buildTexture:Texture = objectsTextureAtlas.getTexture("buildArea");
			var buildImage:Image = new Image(buildTexture);
			var newBuildZone:BuildZone = new BuildZone(sWidth/2 + 150, (sHeight - 95), buildImage);
			buildZones.push(newBuildZone);
			addChild(newBuildZone);
			
			var buildTexture2:Texture = objectsTextureAtlas.getTexture("buildArea");
			var buildImage2:Image = new Image(buildTexture2);
			newBuildZone = new BuildZone(150, (sHeight - 95), buildImage2);
			buildZones.push(newBuildZone);
			addChild(newBuildZone);
			
			
			//Create a list of landing zones
			shoreList = new Array();
			//Spawn some shores
			newShore = new Shore(width/2, (height - 200));
			addChild(newShore);
			shoreList.push(newShore);
			
			textField = new TextField(120, 40, "0", "Arial", 24, Color.RED);
			textField.border = true;
			addChild(textField);
			
			
			//Add listener which waits for stage creation
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			
			//Create the enemy spawner
			enemySpawner = new EnemySpawner(shoreList, generatePaths(), levelBase);
			addChild(enemySpawner);
			
			
			//Create a new cannon
			newCannon = new Cannon((width/2 - 250), (height - 260), objectsTextureAtlas);
			addChild(newCannon);
			
			//Set the last created cannon as the current selected 
			//replace this later with mouse selection
			selectedCannon = newCannon;
			
		}
		//Called each frame
		public function onUpdate():void{
			
			if(enemySpawner.enemiesList.length < 20 && !isSpawning && !paused){
				//Pick a random time between spawns
				var randTime:Number = Math.floor(Math.random() * 2000) + 750;
				
				isSpawning = true;
				var spawnTimer:Timer = new Timer(randTime, 1);
				spawnTimer.addEventListener(TimerEvent.TIMER, timedSpawn);
				spawnTimer.start();
			}
		}
		//Tell the enemy spawner to spawn a single enemy
		public function timedSpawn(event:TimerEvent):void{
			if(!paused){
				isSpawning = false;
				enemySpawner.createEnemy();
			}
			else if(paused){
				isSpawning = false;
			}
		}
		//May want to condense
		public function generatePaths():Array{
			pathArray = new Array();
			
			//Make your paths here, the more the better.
			newPath = new Array({x:100, y:-100},
				{x:200, y:250},
				{x:shores[0].x, y:shores[0].y});
			pathArray.push(newPath);
			
			newPath = new Array({x:1100, y:-100},
				{x:1000, y:250},
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
			
			//Add player projectile fire listener
			stage.addEventListener(BuildStarted.BUILD, onBuildStarted);
			
			//Used for game loop
			stage.addEventListener(Event.ENTER_FRAME, this.onUpdate);
			
			//Used for game loop
			stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
			
			//Remove the uneeded stage creation listener
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		protected function onKeyDown(event:KeyboardEvent):void{
			if(event.keyCode == 27 && paused == false){
				trace("Pressed escape");
				TweenMax.pauseAll();
				paused = true;
			}
			else if(event.keyCode == 27 && paused == true){
				trace("Pressed escape");
				TweenMax.resumeAll();
				paused = false;
			}
		}
		
		//Called whenever a build zone is touched
		private function onBuildStarted(event:BuildStarted):void{
			//If the player has enough money, and there is not already a tower here, spawn one
			if(currency >= 1000 && event.buildZone.occupied == false && !paused){
				//Create an allied lobber (for testing, will be placed by player in future)
				var newLobber:Lobber = new Lobber(event.buildZone.x, event.buildZone.y, objectsTextureAtlas, enemySpawner);
				event.buildZone.occupied = true;
				addChild(newLobber);
				
				//Subtract the price from currency
				currency -= 1000;
				textField.text = currency.toString();
				
				//Remove this build zone from the array and destroy it
				var tempIndex:Number = buildZones.indexOf(event.buildZone);
				buildZones.splice(tempIndex, 1);
				event.buildZone.removeFromParent(true);
			}
		}
		//Called when a shot has been fired into an object which accepts shots
		private function onProjectileFired(event:ProjectileFired):void{
			var touchLoc:Point = event.touch.getLocation(selectedCannon);
			if(!paused){
				selectedCannon.shootBullet(touchLoc);
			}
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
					if(tempProjectile.getBounds(stage).intersects(enemy.hitBox.getBounds(stage))){
						//Check to see if it has reached the shore or not yet
						if(enemy.canDamage){
							currency += enemy.value;
							textField.text = currency.toString();

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