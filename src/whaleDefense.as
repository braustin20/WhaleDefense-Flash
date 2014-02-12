package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import com.manage.Game;
	
	import starling.core.Starling;
	
	[SWF(width="400", height="300", frameRate="60", backgroundColor="#000000")]
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