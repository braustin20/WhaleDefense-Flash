package com.manage
{
	import com.actors.Cannon;
	
	import starling.display.Sprite;
	
	public class Game extends Sprite
	{
		private var cannonTest:Cannon;
		
		public function Game()
		{
			cannonTest = new Cannon();
			addChild(cannonTest);
		}
	}
}