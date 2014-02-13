package com
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import com.game.Game;
	
	//import com.greensock.plugins.TweenPlugin; 
	//import com.greensock.plugins.BezierPlugin; 
	
	import starling.core.Starling;
	
	[SWF(width="1280", height="720", frameRate="60", backgroundColor="#000000")]
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
			
			//weenPlugin.activate([BezierPlugin]);
		}
	}
}