package com.game
{	
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	
	import flash.geom.Point;
	
	import starling.display.Sprite;

	
	public class EnemySpawner extends Sprite
	{
		private var enemyList:Array;
		private var newEnemy:Enemy;
		private var shores:Array;
		
		//Contructor should take in two arrays, one for enemy spawn locations, one for shore locations
		public function EnemySpawner(shoreList:Array){
			//Create the list to store enemies
			enemyList = new Array();
			
			shores = shoreList;
			
			//Create enemies (will sophisticate later)
			createEnemy(100, 600);
			createEnemy(200, 600);
			createEnemy(300, 600);
			createEnemy(400, 600);
			createEnemy(500, 600);
			createEnemy(600, 600);
			
			
		}
		public function createEnemyPath(enemy:Enemy):void{
			//For now, just find a random shore and go to it, later will sophisticate
			var rand:Number;
			rand = Math.floor(Math.random() * (1 + (shores.length - 1))) + 0;
			
			//Save the chosen shore into the enemy
			enemy.targetShore = shores[rand];
			
			TweenMax.to(enemy, velocityToDuration(enemy), {x:enemy.targetShore.x, y:enemy.targetShore.y, ease:Linear.easeNone});
		}
		public function createEnemy(xPos:Number, yPos:Number):void{
			newEnemy = new Enemy(xPos, yPos);
			addChild(newEnemy);
			//Add the enemy to the enemy list
			enemyList.push(newEnemy);
			
			newEnemy.listIndex = enemyList.indexOf(newEnemy);
			createEnemyPath(newEnemy);
		}
		public function get enemiesList():Array{
			return enemyList;
		}
		//Calculates duration in seconds from a given speed
		private function velocityToDuration(enemy:Enemy):Number{
			var duration:Number;
			var p1:Point = new Point(enemy.x, enemy.y);
			var p2:Point = new Point(enemy.targetShore.x, enemy.targetShore.y);
			
			var distance:Number = Point.distance(p1, p2);
			
			duration = Math.abs(distance/enemy.speed);
			return duration;
		}
	}
}