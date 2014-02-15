package com.game
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	
	import flash.geom.Point;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.Color;

	public class Cannon extends Sprite
	{
		private var graphics:Quad;
		private var bullet:Bullet;
		private var arcArray:Array;
		
		public var arcHeight:Number;
		public var fireSpeed:Number;
		
		public function Cannon()
		{
			this.x = 300;
			this.y = 150;
			
			arcHeight = 200;
			fireSpeed = 1;
			
			//Placeholder sprite
			graphics = new Quad(100, 100, Color.RED);
			//Move the sprite so that it's centered
			graphics.x = this.x - graphics.width/2;
			graphics.y = this.y - graphics.height/2;
			addChild(graphics);
			
		}
		
		public function shootBullet(touchLoc:Point):void{
			//Add a bullet relative to this cannon
			bullet = new Bullet(this.x, this.y);
			
			
			
			stage.addChild(bullet);
			
			//Calculate the mid control point for the bezier arc
			var controlPoint:Point = getControl(new Point(bullet.x, bullet.y), touchLoc, arcHeight);
			
			//Assemble the anchors and control point into an array for brevity
			arcArray = [new Point(bullet.x, bullet.y), controlPoint, touchLoc];
			
			//--------Debug point display-------------
			var targ:Quad = new Quad(5, 5, Color.AQUA);
			targ.x = controlPoint.x;
			targ.y = controlPoint.y;
			addChild(targ);
			
			var targ2:Quad = new Quad(5, 5, Color.AQUA);
			targ2.x = bullet.x;
			targ2.y = bullet.y;
			addChild(targ2);
			
			var targ3:Quad = new Quad(5, 5, Color.AQUA);
			targ3.x = touchLoc.x;
			targ3.y = touchLoc.y;
			addChild(targ3);
			
			//Fire the bullet along a bezier curve
			TweenMax.to(bullet, fireSpeed, {bezier:{values:arcArray, type:"quadratic"}, ease:Linear.easeOut, onComplete:bullet.destroy});		
		}
		//Used to calculate the correct control point between two bezier anchors
		private function getControl(pointA:Point, pointB:Point, h:Number):Point{
			//Get the middle coordinates between the two given points
			var midX:Number = (pointA.x + pointB.x) / 2;
			var midY:Number = (pointA.y + pointB.y) / 2;
			
			//Get the angle of the line
			var t:Number = Math.atan(-1 / ((pointB.y - pointA.y) / (pointB.x - pointA.x)));
			
			//Place a point h distance above the midpoint dependant on line angle
			var controlPoint:Point = new Point(Math.cos(t) * h + midX, Math.sin(t) * h + midY);
			
			return controlPoint; 
		}
	}
}