package com.game
{	
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	
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
			TweenMax.to(enemy, 8, {x:shores[rand].x, y:shores[rand].y, ease:Linear.easeNone});
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
	}
}