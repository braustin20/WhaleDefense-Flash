package com.actors
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.Color;

	public class Cannon extends Sprite
	{
		private var graphics:Quad;
		
		public function Cannon()
		{
			graphics = new Quad(100, 100, Color.RED);
			graphics.x = 100;
			graphics.y = 50;
			addChild(graphics);
		}
	}
}