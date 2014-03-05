package com.game
{	
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	
	import flash.geom.Point;
	
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	
	public class EnemySpawner extends Sprite
	{
		
		
		//The texture atlases used
		public var enemyTextureAtlas:TextureAtlas;
		
		private var enemyList:Array;
		private var newEnemy:Enemy;
		private var shores:Array;
		public var enemyPaths:Array;
		private var levelBase:Base;
		private var mainGame:Game;
		
		//Contructor should take in two arrays, one for enemy spawn locations, one for shore locations
		public function EnemySpawner(game:Game, shoreList:Array, paths:Array, mBase:Base){
			mainGame = game;

			
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
			var newSprite:MovieClip = new MovieClip(mainGame.assets.getTextures("WhaleSprite"), 1);
			newEnemy = new Enemy(0, 0, newSprite);
			newEnemy.canDamage = true;
			
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
			}
			
			//Remove all trace of the enemy
			enemy.destroy();
			var enemyIndex:Number = enemiesList.indexOf(enemy);
			enemiesList.splice(enemyIndex, 1);
			
		}
		
		//Calculates duration in seconds from a given speed
		private function velocityToDuration(enemy:Enemy):Number{
			var duration:Number;
			var p1:Point = new Point(enemy.x, enemy.y);
			var p2:Point = new Point(enemyPaths[enemy.targetPath][enemyPaths[enemy.targetPath].length - 1].x, 
										enemyPaths[enemy.targetPath][enemyPaths[enemy.targetPath].length - 1].y);
			
			var distance:Number = Point.distance(p1, p2);
			
			duration = Math.abs(distance/enemy.speed);
			return duration;
		}
		
		public function get enemiesList():Array{
			return enemyList;
		}
	}
}