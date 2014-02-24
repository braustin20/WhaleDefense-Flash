package com.game
{	
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import com.greensock.motionPaths.LinePath2D;
	import com.greensock.motionPaths.PathFollower;
	
	import flash.geom.Point;
	
	import starling.display.Sprite;

	
	public class EnemySpawner extends Sprite
	{
		private var enemyList:Array;
		private var newEnemy:Enemy;
		private var shores:Array;
		public var enemyPaths:Array;
		private var levelBase:Base;
		
		//Contructor should take in two arrays, one for enemy spawn locations, one for shore locations
		public function EnemySpawner(shoreList:Array, paths:Array, mBase:Base){
			//Create the list to store enemies
			enemyList = new Array();
			
			shores = shoreList;
			
			enemyPaths = paths;
			
			levelBase = mBase;
			
			
			//Create enemies (will sophisticate later)
			createEnemy();
	//		createEnemy(200, 600);
	//		createEnemy(300, 600);
	//		createEnemy(400, 600);
	//		createEnemy(500, 600);
	//		createEnemy(600, 600);
			
			//testPath.distribute(enemyList, 0, .8, true, 0);
			
			//animatePath();
			
			
		}
		public function animatePath():void{
			//TweenMax.to(testPath, 20, {progress:1, onComplete:testPath.removeFollower(});
			
		}
		public function createEnemyPath(enemy:Enemy):void{
			//For now, just find a random shore and go to it, later will sophisticate
			/*var rand:Number;
			rand = Math.floor(Math.random() * (1 + (shores.length - 1))) + 0;
			
			//Save the chosen shore into the enemy
			enemy.targetShore = shores[rand];
			
			TweenMax.to(enemy, velocityToDuration(enemy), {x:enemy.targetShore.x, y:enemy.targetShore.y, ease:Linear.easeNone});*/
			//testPath.addFollower(enemy, 0, true, 0);
			
			var rand:Number = Math.floor(Math.random() * (1 + (enemyPaths.length - 1))) + 0;
			enemy.targetPath = rand;
			
			//var follower:PathFollower = enemyPaths[rand].addFollower(enemy, 0, true, 0);
			enemy.attachedFollower = enemyPaths[rand].addFollower(enemy, 0, true, 0);
			TweenMax.to(enemy.attachedFollower, velocityToDuration(enemy), {progress:1, ease:Linear.easeNone, onComplete:removeFromShorePath, onCompleteParams:[enemy.attachedFollower, enemy]});
		}
		public function createEnemy():void{
			//var rand:Number = Math.floor(Math.random() * (1 + (enemyPaths.length - 1))) + 0;
			
			newEnemy = new Enemy(0, 0);
			newEnemy.canDamage = true;
			
			addChild(newEnemy);
			//Add the enemy to the enemy list
			enemyList.push(newEnemy);
			newEnemy.listIndex = enemyList.indexOf(newEnemy);
			
			createEnemyPath(newEnemy);
		}
		//Function to transfer movement over to face the base
		public function removeFromShorePath(follower:PathFollower, enemy:Enemy):void{
			//If the tween is completed, remove from this path
			if(follower.progress >= 1){
				enemyPaths[enemy.targetPath].removeFollower(enemy.attachedFollower);
			}
			//If the enemy is alive, send him toward the base
			if(!enemy.isDead){
				var basePath:LinePath2D = new LinePath2D([new Point(enemy.x, enemy.y),
					new Point(levelBase.x, levelBase.y)]);
				
				enemy.attachedFollower = basePath.addFollower(enemy, 0, true, 0);
				TweenMax.to(enemy.attachedFollower, 8, {progress:1, ease:Linear.easeNone, onComplete:removeFromBasePath, onCompleteParams:[enemy.attachedFollower, enemy]});
			}
			//Since the enemy is now on shore, he can't be hurt
			enemy.canDamage = false;
			
		}
		//Once the enemy hits the base, remove him from the base path
		public function removeFromBasePath(follower:PathFollower, enemy:Enemy):void{
			if(follower.progress >= 1){
				enemyPaths[0].removeFollower(enemy.attachedFollower);
			}
			
			//Deal some damage to the base
			if(!enemy.isDead){
				levelBase.dealDamage(34);
			}
			
			//Remove all trace of the enemy
			enemy.destroy();
			var enemyIndex:Number = enemiesList.indexOf(enemy);
			enemiesList.splice(enemyIndex, 1);
			
		}
		
		//Calculates duration in seconds from a given speed
		private function velocityToDuration(enemy:Enemy):Number{
			var duration:Number;
		//	var p1:Point = new Point(enemy.x, enemy.y);
		//	var p2:Point = new Point(enemy.targetShore.x, enemy.targetShore.y);
			
		//	var distance:Number = Point.distance(p1, p2);
			var distance:Number = enemyPaths[enemy.targetPath].totalLength;
			
			duration = Math.abs(distance/enemy.speed);
			return duration;
		}
		
		public function get enemiesList():Array{
			return enemyList;
		}
	}
}