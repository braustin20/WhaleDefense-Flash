package com.game
{	
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	
	import flash.geom.Point;
	
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import flash.media.Sound;

	
	public class EnemySpawner extends Sprite
	{	
		private var enemyList:Array;
		private var newEnemy:Enemy;
		private var shores:Array;
		
		public var enemyPaths:Array;
		
		private var levelBase:Base;
		private var mainGame:Game;
		
		private var sandHitSound:Sound;
		
		public var damageMultiplier:Number = 1.0;
		public var speedMultiplier:Number = 1.0;
		
		//Contructor should take in two arrays, one for enemy spawn locations, one for shore locations
		public function EnemySpawner(game:Game, shoreList:Array, paths:Array, mBase:Base, speed:Number=1.0, damage:Number=1.0){
			mainGame = game;
			
			speedMultiplier = speed;
			damageMultiplier = damage;
			
			sandHitSound = mainGame.assets.getSound("sandHit");
			
			//Create the list to store enemies
			enemyList = new Array();
			
			//List of landing areas
			shores = shoreList;
			
			//Pairs of x and y variabes representing a bezier
			enemyPaths = paths;
			
			//The player's base
			levelBase = mBase;
			
			//Create enemies (will sophisticate later)
			createEnemy();
			
		}
		public function createEnemyPath(enemy:Enemy):void{
			//Pick a random path to follow
			var rand:Number = Math.floor(Math.random() * (1 + (enemyPaths.length - 1))) + 0;
			enemy.targetPath = rand;
			
			//Move the enemy to the start of the bezier path
			enemy.x = enemyPaths[rand][0].x;
			enemy.y = enemyPaths[rand][0].y;
			
			//Tween along the bezier, orienting the angle along the way with a static speed
			TweenMax.to(enemy, velocityToDuration(enemy), {bezierThrough:enemyPaths[rand], orientToBezier:[["x", "y", "rotation", 1.5, 1]], ease:Linear.easeNone, onComplete:removeFromShorePath, onCompleteParams:[enemy]});
		}
		public function createEnemy():void{		
			var newSprite:MovieClip = new MovieClip(mainGame.assets.getTextures("WhaleSpriteAnim_"), 3.5);
			newEnemy = new Enemy(0, 0, newSprite);
			newEnemy.canDamage = true;
			newEnemy.speed *= speedMultiplier;
			newEnemy.damage *= damageMultiplier;
			
			addChild(newEnemy);
			
			//Add the enemy to the enemy list
			enemyList.push(newEnemy);
			newEnemy.listIndex = enemyList.indexOf(newEnemy);
			
			createEnemyPath(newEnemy);
		}
		//Function to transfer movement over to face the base
		public function removeFromShorePath(enemy:Enemy):void{

			//If the enemy is alive, send him toward the base
			if(!enemy.isDead){
				//Create a straight line between the shore and base
				var basePath:Array = new Array({x:enemy.x, y:enemy.y},
					{x:levelBase.x, y:levelBase.y});
				
				//Tween along the bezier, orienting the angle along the way with a static speed
				TweenMax.to(enemy, 0.5, {bezierThrough:basePath, orientToBezier:[["x", "y", "rotation", 1.5, 1]], ease:Linear.easeNone, onComplete:removeFromBasePath, onCompleteParams:[enemy]});
			}
			//Since the enemy is now on shore, he can't be hurt
			enemy.canDamage = false;
			
		}
		//Once the enemy hits the base, remove him from the base path
		public function removeFromBasePath(enemy:Enemy):void{
			
			//Deal some damage to the base
			if(!enemy.isDead){
				levelBase.dealDamage(enemy.damage);
				sandHitSound.play(0, 0, mainGame.effectsTransform);
				trace("dealing damage");
			}
			
			//Remove all trace of the enemy
			enemy.destroy();
			var enemyIndex:Number = enemiesList.indexOf(enemy);
			enemiesList.splice(enemyIndex, 1);
			
		}
		
		//Calculates duration in seconds from a given speed
		private function velocityToDuration(enemy:Enemy):Number{
			var duration:Number;
			
			var prevPoint:Point;
			var nextPoint:Point;
			var distance:Number = 0;
			
			//Iterate through each point in the path and accumulate their distances
			for each(var point:Object in enemyPaths[enemy.targetPath]){
				//The next point to calculate
				nextPoint = new Point(point.x, point.y);
				
				//As long as this isn't the first iteration, add some distance
				if(prevPoint != null){
					distance += Point.distance(prevPoint, nextPoint);
				}
				
				//The point we just calculated becomes the base of the next calc
				prevPoint = nextPoint;
			}
			
			//The duration is the distance divided by the enemy's speed
			duration = Math.abs(distance/enemy.speed);
			return duration;
		}
		
		public function get enemiesList():Array{
			return enemyList;
		}
	}
}