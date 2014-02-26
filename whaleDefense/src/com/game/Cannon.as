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
		private var newPlayerProjectile:PlayerProjectile;
		private var arcArray:Array;
		
		public var arcHeight:Number;
		public var velocity:Number;
		
		public function Cannon(xPos:Number, yPos:Number)
		{
			this.x = xPos;
			this.y = yPos;
			
			arcHeight = 200;
			velocity = 1750;
			
			//Placeholder sprite
			graphics = new Quad(30, 40, Color.RED);
			//Move the sprite so that it's centered
			graphics.x -= graphics.width/2;
			graphics.y -= graphics.height/2;
			addChild(graphics);
			
		}
		
		public function shootBullet(touchLoc:Point):void{
			//Add a newPlayerProjectile relative to this cannon
			newPlayerProjectile = new PlayerProjectile(0, 0);
			
			addChild(newPlayerProjectile);
			
			
			//Calculate the mid control point for the bezier arc
			var controlPoint:Point = getControl(new Point(newPlayerProjectile.x, newPlayerProjectile.y), touchLoc, calculateArcHeight(touchLoc));
			
			//Assemble the anchors and control point into an array for brevity
			arcArray = [new Point(newPlayerProjectile.x, newPlayerProjectile.y), controlPoint, touchLoc];
			
			//--------Debug bezier point display-------------
			/*var targ:Quad = new Quad(5, 5, Color.AQUA);
			targ.x = controlPoint.x;
			targ.y = controlPoint.y;
			addChild(targ);
			
			var targ2:Quad = new Quad(5, 5, Color.AQUA);
			targ2.x = newPlayerProjectile.x;
			targ2.y = newPlayerProjectile.y;
			addChild(targ2);
			
			var targ3:Quad = new Quad(5, 5, Color.AQUA);
			targ3.x = touchLoc.x;
			targ3.y = touchLoc.y;
			addChild(targ3);*/
			
			//Fire the newPlayerProjectile along a bezier curve
			//Set onCompleteParams to signify that this is a player's shot
			TweenMax.to(newPlayerProjectile, velocityToDuration(touchLoc), {bezier:{values:arcArray, type:"quadratic"}, ease:Linear.easeOut, onComplete:newPlayerProjectile.destroy, onCompleteParams:[true]});		
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
		//Calculates duration in seconds from a given speed
		private function velocityToDuration(p2:Point):Number{
			var duration:Number;
			var p1:Point = new Point(newPlayerProjectile.x, newPlayerProjectile.y);
			
			var distance:Number = Point.distance(p1, p2);
			
			duration = Math.abs(distance/velocity);
			return duration;
		}
		//Rough control over arc height dependant on distance
		private function calculateArcHeight(p2:Point):Number{
			var tempArcHeight:Number;
			var p1:Point = new Point(newPlayerProjectile.x, newPlayerProjectile.y);
			
			var distance:Number = Point.distance(p1, p2);
			tempArcHeight = Math.floor(distance/3)

			return tempArcHeight;
		}
	}
}