package com.allies
{
	
	import starling.display.Sprite;
	import starling.display.Image;
	
	public class BuildZone extends Sprite
	{
		public var occupied:Boolean = false;
		private var graphics:Image;
		
		public function BuildZone(xPos:Number, yPos:Number, sprite:Image)
		{
			super();
			
			this.x = xPos;
			this.y = yPos;
			this.alignPivot();
				
			graphics = sprite;
			graphics.alignPivot();
			graphics.scaleX = .8;
			graphics.scaleY = .8;
			addChild(graphics);
		}
	}
}