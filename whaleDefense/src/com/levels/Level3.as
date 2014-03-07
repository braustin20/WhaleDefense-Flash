package com.levels
{
	import com.allies.BuildZone;
	import com.allies.GenericAlly;
	import com.allies.Lobber;
	import com.events.BuildStarted;
	import com.events.MenuButtonPressed;
	import com.events.ProjectileFired;
	import com.events.ProjectileHit;
	import com.game.Base;
	import com.game.Catapult;
	import com.game.Enemy;
	import com.game.EnemySpawner;
	import com.game.FireExplosion;
	import com.game.Game;
	import com.game.GenericProjectile;
	import com.game.LevelBottomLayer;
	import com.game.LevelTopLayer;
	import com.game.Shore;
	import com.game.SplashExplosion;
	import com.greensock.TweenMax;
	import com.ui.GameOverMenu;
	import com.ui.GameWonMenu;
	import com.ui.PauseMenu;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.utils.Timer;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	public class Level3 extends Sprite
	{
		public var levelBase:Base;
		
		private var newCatapult:Catapult;
		
		public var buildZones:Array;
		
		private var shoreList:Array;
		private var newShore:Shore;
		private var newPath:Array;
		public var pathArray:Array;
		
		private var isSpawning:Boolean;
		
		private var textField:TextField;
		public var currency:Number = 0;
		
		public var paused:Boolean;
		
		private var alphaCutoff:Number = 5;
		
		private var allies:Array;
		
		public var enemySpawner:EnemySpawner;
		private var enemiesDestroyed:Number;
		private var killsToWin:Number;
		
		private var bottomLayer:LevelBottomLayer;
		private var topLayer:LevelTopLayer;
		
		private var explSound:Sound;
		private var splashSound:Sound;
		private var launchSound:Sound;
		
		private var mainGame:Game;
		private var pauseMenu:PauseMenu;
		
		public function Level3(game:Game)
		{	
			mainGame = game;
			init();
		}
		protected function init():void{
			enemiesDestroyed = 0;
			killsToWin = 45;
			
			explSound = mainGame.assets.getSound("explosion");
			splashSound = mainGame.assets.getSound("splash");
			launchSound = mainGame.assets.getSound("woosh");
			
			var waterTexture:Texture = mainGame.assets.getTexture("Level3_water");
			var waterImage:Image = new Image(waterTexture);
			bottomLayer = new LevelBottomLayer(waterImage, "Level3_water");
			addChild(bottomLayer);
			
			
			var shoreTexture:Texture = mainGame.assets.getTexture("Level3_shore");
			var shoreImage:Image = new Image(shoreTexture);
			topLayer = new LevelTopLayer(shoreImage, "Level3_shore");
			addChild(topLayer);
			
			//Add the base that the player has to defend
			var baseTexture:Texture = mainGame.assets.getTexture("castleSm");
			var baseImage:Image = new Image(baseTexture);
			levelBase = new Base(1132, 617, baseImage);
			levelBase.rotation = -1.57;
			addChild(levelBase);
			
			//Create the areas where the player is able to build defenses
			buildZones = new Array();
			
			var buildTexture:Texture = mainGame.assets.getTexture("buildArea");
			
			var newBuildZone:BuildZone = new BuildZone(485, 86, buildTexture);
			buildZones.push(newBuildZone);
			addChild(newBuildZone);
			
			newBuildZone = new BuildZone(177, 441, buildTexture);
			buildZones.push(newBuildZone);
			addChild(newBuildZone);
			
			newBuildZone = new BuildZone(657, 488, buildTexture);
			buildZones.push(newBuildZone);
			addChild(newBuildZone);
			
			newBuildZone = new BuildZone(519, 268, buildTexture);
			buildZones.push(newBuildZone);
			addChild(newBuildZone);
			
			newBuildZone = new BuildZone(810, 174, buildTexture);
			buildZones.push(newBuildZone);
			addChild(newBuildZone);
			
			newBuildZone = new BuildZone(1076, 370, buildTexture);
			buildZones.push(newBuildZone);
			addChild(newBuildZone);
			
			allies = new Array();
			
			//Create a list of landing zones
			shoreList = new Array();
			//Spawn some shores
			newShore = new Shore(933, 585);
			addChild(newShore);
			shoreList.push(newShore);
			
			//Add listener which waits for stage creation
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
			
			//Create the enemy spawner
			enemySpawner = new EnemySpawner(mainGame, shoreList, generatePaths(), levelBase);
			addChild(enemySpawner);
			
			
			//Create a new cannon
			newCatapult = new Catapult(391, 640, mainGame);
			addChild(newCatapult);
			
			//The "score" keeper
			textField = new TextField(220, 40, ("Coins: " + "0"), "Arial", 24, Color.RED);
			textField.border = true;
			addChild(textField);
			
			var pauseTextField:TextField = new TextField(220, 40, ("Press 'P' to Pause"), "Arial", 20, Color.RED);
			pauseTextField.x = mainGame.stageWidth - pauseTextField.width;
			addChild(pauseTextField);
		}
		//Called each frame
		public function onUpdate():void{
			if(this.levelBase.health <= 0 && !paused){
				var gameOverMenu:GameOverMenu = new GameOverMenu(mainGame);
				addChild(gameOverMenu);
				paused = true;
				for each(var ally:GenericAlly in allies){
					ally.paused = true;
				}
				TweenMax.pauseAll();
			}
			if(enemySpawner.enemiesList.length < 20 && !isSpawning && !paused){
				//Pick a random time between spawns
				var randTime:Number = Math.floor(Math.random() * 2000) + 750;
				
				isSpawning = true;
				var spawnTimer:Timer = new Timer(randTime, 1);
				spawnTimer.addEventListener(TimerEvent.TIMER, timedSpawn);
				spawnTimer.start();
				enemySpawner.speedMultiplier += .05;
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
			newPath = new Array({x:36, y:-100},
				{x:138, y:117},
				{x:28, y:347},
				{x:124, y:548},
				{x:349, y:503},
				{x:506, y:479},
				{x:584, y:618},
				{x:787, y:560},
				{x:shores[0].x, y:shores[0].y});
			pathArray.push(newPath);
			
			newPath = new Array({x:1125, y:-100},
				{x:1230, y:231},
				{x:974, y:275},
				{x:895, y:342},
				{x:861, y:503},
				{x:shores[0].x, y:shores[0].y});
			pathArray.push(newPath);
			
			newPath = new Array({x:700, y:-100},
				{x:634, y:177},
				{x:634, y:324},
				{x:510, y:466},
				{x:613, y:611},
				{x:837, y:544},
				{x:shores[0].x, y:shores[0].y});
			pathArray.push(newPath);
			
			newPath = new Array({x:700, y:-100},
				{x:634, y:177},
				{x:640, y:337},
				{x:924, y:341},
				{x:834, y:538},
				{x:shores[0].x, y:shores[0].y});
			pathArray.push(newPath);
			
			newPath = new Array({x:1271, y:93},
				{x:1223, y:177},
				{x:1185, y:260},
				{x:1018, y:284},
				{x:891, y:318},
				{x:713, y:328},
				{x:595, y:361},
				{x:513, y:471},
				{x:526, y:583},
				{x:634, y:627},
				{x:813, y:565},
				{x:shores[0].x, y:shores[0].y});
			pathArray.push(newPath);

			return pathArray;
		}
		
		//Once the stage is created, add the remaining listeners
		public function onAddedToStage(event:Event):void{		
			//Add player projectile hit listener
			this.addEventListener(ProjectileHit.HIT, onProjectileHit);
			
			//Add player projectile fire listener
			this.addEventListener(ProjectileFired.FIRED, onProjectileFired);
			
			//Add player projectile fire listener
			this.addEventListener(BuildStarted.BUILD, onBuildStarted);
			
			//Used for game loop
			this.addEventListener(Event.ENTER_FRAME, this.onUpdate);
			
			//Used for game loop
			this.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
			
			
			this.addEventListener(MenuButtonPressed.PRESSED, onButtonPressed);
			
			this.addEventListener(TouchEvent.TOUCH, onTouch);
			
			//Remove the uneeded stage creation listener
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		public function onTouch(event:TouchEvent):void{
			//Touch data when clicked or tapped down
			var touchDown:Touch = event.getTouch(this, TouchPhase.ENDED);
			
			
			//If tapped or clicked, test fire the current cannon at the cursor location
			if (touchDown && getBounds(this).containsPoint(touchDown.getLocation(this))){
				
				//Get the pixel from the water layer, which is at the point of impact
				var color:uint = this.bottomLayer.layerBmpData.getPixel32(touchDown.getLocation(this).x, touchDown.getLocation(this).y);
				//If this color is visible within reason, and not transparent, make a splash
				if (Color.getAlpha(color) > alphaCutoff) {
					//Dispatch the event and denote who was the shooter
					dispatchEvent(new ProjectileFired(ProjectileFired.FIRED, touchDown, true, true));	
				}
				trace("{x:" + touchDown.getLocation(this).x + ", y:" + touchDown.getLocation(this).y +"},");		
			}
		}
		protected function onKeyDown(event:KeyboardEvent):void{
			//If the P key is pressed, pause the game
			if((event.keyCode == 112 || event.keyCode == 80 || event.keyCode == 27) && paused == false){
				pauseMenu = new PauseMenu(mainGame);
				addChild(pauseMenu);
				paused = true;
				for each(var ally:GenericAlly in allies){
					ally.paused = true;
				}
				TweenMax.pauseAll();
				trace("Pressed pause");
			}
		}
		
		//Called whenever a build zone is touched
		private function onBuildStarted(event:BuildStarted):void{
			//If the player has enough money, and there is not already a tower here, spawn one
			if(currency >= 1000 && event.buildZone.occupied == false && !paused){
				//Create an allied lobber (for testing, will be placed by player in future)
				var newLobber:Lobber = new Lobber(event.buildZone.x, event.buildZone.y, mainGame, enemySpawner);
				allies.push(newLobber);
				event.buildZone.occupied = true;
				addChild(newLobber);
				
				//Subtract the price from currency
				currency -= 1000;
				textField.text = ("Coins: " + currency.toString());
				
				//Remove this build zone from the array and destroy it
				var tempIndex:Number = buildZones.indexOf(event.buildZone);
				buildZones.splice(tempIndex, 1);
				event.buildZone.removeFromParent(true);
			}
		}
		//Called when a shot has been fired into an object which accepts shots
		private function onProjectileFired(event:ProjectileFired):void{
			var touchLoc:Point = event.touch.getLocation(newCatapult);
			if(!paused && newCatapult.isReloaded){
				launchSound.play(0, 0, mainGame.effectsTransform);
				newCatapult.shootBullet(touchLoc);
			}
		}
		//This is typically called when a player bullet finishes it's animation
		public function onProjectileHit(event:ProjectileHit):void{
			//Store the projectile passed through from the event
			var tempProjectile:GenericProjectile = event.projectile;
		//	var hitPoint:Point = globalToLocal(tempProjectile.localToGlobal(new Point(tempProjectile.x , tempProjectile.y)));
			var hitPoint:Point = new Point(tempProjectile.graphics.getBounds(stage).x + (tempProjectile.graphics.width/2), tempProjectile.getBounds(stage).y + (tempProjectile.graphics.height/2));
			
			//If the object which triggered this was a player cannon, try to destroy an enemy
			if(event.isPlayer){
				//Test if the enemy was hit for audio/particle reasons
				var enemyHit:Boolean = false;
				//Search through the list of enemies to see if we just hit one
				for each (var enemy:Enemy in enemySpawner.enemiesList){
					//If the sprites intersect, destroy the ship
					if(tempProjectile.graphics.getBounds(stage).intersects(enemy.hitBox.getBounds(stage))){
						//Check to see if it has reached the shore or not yet
						if(enemy.canDamage){
							var explosion:FireExplosion = new FireExplosion(enemy.x, enemy.y, mainGame);
							addChild(explosion);
							
							explSound.play(0, 0, mainGame.effectsTransform);
							currency += enemy.value;
							textField.text = ("Coins: " + currency.toString());

							//Set the enemy to dead, so that they don't make a path to the base
							enemy.isDead = true;
							
							//Find it's index and remove it from the array of enemies
							var enemyIndex:Number = enemySpawner.enemiesList.indexOf(enemy);
							enemySpawner.enemiesList.splice(enemyIndex, 1);
							
							//Destroy the enemy
							enemy.destroy();
							
							enemiesDestroyed += 1;
			
							if(enemiesDestroyed >= killsToWin){
								endGame();
							}
							
						}
						enemyHit = true;
					}
				}
				//If the enemy was not hit, check to see what object was
				if(enemyHit == false){
					//Get the pixel from the water layer, which is at the point of impact
					var color:uint = this.bottomLayer.layerBmpData.getPixel32(hitPoint.x, hitPoint.y);
					//If this color is visible within reason, and not transparent, make a splash
					if (Color.getAlpha(color) > alphaCutoff) {
						var splash:SplashExplosion = new SplashExplosion(hitPoint.x, hitPoint.y, mainGame);
						addChild(splash);
						
						splashSound.play(0, 0, mainGame.effectsTransform);
					}
					//If it didn't hit water, make it appear to hit ground
					else{
						//Rock ground hit here
					}
				}
			}
		}
		private function endGame():void{
			var gameWonMenu:GameWonMenu = new GameWonMenu(mainGame);
			addChild(gameWonMenu);
			paused = true;
			for each(var ally:GenericAlly in allies){
				ally.paused = true;
			}
			TweenMax.pauseAll();
			trace("Game Won");
		}
		protected function onButtonPressed(event:MenuButtonPressed):void{
			switch(event.buttonName){
				case "Resume" :
						pauseMenu.removeFromParent(true);
						paused = false;
						TweenMax.resumeAll();
						for each(var ally:GenericAlly in allies){
							ally.paused = false;
						}
					break;
				case "Next Level":
					mainGame.switchLevels("Main Menu Exit");
					break;
				case "Retry":
					mainGame.switchLevels("Level 3");
					break;
				case "Exit":
					mainGame.switchLevels("Main Menu Exit");
					break;
				default:
					trace("Button has no listener");
			}
		}
		public function get shores():Array{
			return this.shoreList;
		}
	}
}