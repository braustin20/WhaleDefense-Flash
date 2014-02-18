package com.game
{	
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	
	import starling.display.Sprite;

	
	public class EnemySpawner extends Sprite
	{
		private var enemyList:Array;
		private var newEnemy:Enemy;
		
		public function EnemySpawner(){
			//Create the list to store enemies
			enemyList = new Array();
			
			//Create an Enemy
			createEnemy(100, 300);
			createEnemy(300, 300);
			createEnemy(200, 300);
			
		}
		public function createEnemyPath(enemy:Enemy):void{
			TweenMax.to(enemy, 8, {x:0, y:0, ease:Linear.easeNone});
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