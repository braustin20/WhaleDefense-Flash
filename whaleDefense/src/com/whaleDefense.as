package com
{
	import com.game.Game;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import starling.core.Starling;
	
	[SWF(width="1280", height="682", frameRate="60", backgroundColor="#48c4e7")]
	public class whaleDefense extends Sprite
	{
		private var mStarling:Starling;
		
		public function whaleDefense()
		{
			mStarling = new Starling(Game, stage);
			mStarling.start();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
		}
	}
}