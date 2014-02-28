package com.game{
	import com.levels.Level1;

	import starling.display.Sprite;
	
	public class Game extends Sprite{	
		private var level:Level1;
		
		//Store stage size
		public var stageWidth:Number = 1280;
		public var stageHeight:Number = 720;
		
		public function Game(){
			level = new Level1(stageWidth, stageHeight);
			addChild(level);
		}
	}
}