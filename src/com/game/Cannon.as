package com.game
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.Color;
	import com.greensock.TweenMax;

	public class Cannon extends Sprite
	{
		private var graphics:Quad;
		
		public function Cannon()
		{
			graphics = new Quad(100, 100, Color.RED);
			graphics.x = 250;
			graphics.y = 50;
			addChild(graphics);
			TweenMax.to(this, 1, {bezier:[{x:250, y:50}, {x:900, y:0}]});
		}
	}
}