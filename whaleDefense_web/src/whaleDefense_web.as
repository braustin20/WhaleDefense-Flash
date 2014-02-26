package
{
	import flash.display.Sprite;
	import starling.core.Starling;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import com.game.Game;
	
	[SWF(width="1280", height="720", frameRate="60", backgroundColor="#000000")]
	public class whaleDefense_web extends Sprite
	{
		private var mStarling:Starling;
		
		public function whaleDefense_web()
		{
			// These settings are recommended to avoid problems with touch handling
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			// Create a Starling instance that will run the "Game" class
			mStarling = new Starling(Game, stage);
			mStarling.start();
		}
	}
}