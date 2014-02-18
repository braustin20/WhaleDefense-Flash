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
		private var playerProjectile:PlayerProjectile;
		private var arcArray:Array;
		
		public var arcHeight:Number;
		public var fireDuration:Number;
		
		public function Cannon()
		{
			this.x = 300;
			this.y = 50;
			
			arcHeight = 200;
			fireDuration = 1;
			
			//Placeholder sprite
			graphics = new Quad(30, 40, Color.RED);
			//Move the sprite so that it's centered
			graphics.x -= graphics.width/2;
			graphics.y -= graphics.height/2;
			addChild(graphics);
			
		}
		
		public function shootBullet(touchLoc:Point):void{
			//Add a playerProjectile relative to this cannon
			playerProjectile = new PlayerProjectile(0, 0);
			
			
			addChild(playerProjectile);
			
			//Calculate the mid control point for the bezier arc
			var controlPoint:Point = getControl(new Point(playerProjectile.x, playerProjectile.y), touchLoc, arcHeight);
			
			//Assemble the anchors and control point into an array for brevity
			arcArray = [new Point(playerProjectile.x, playerProjectile.y), controlPoint, touchLoc];
			
			//--------Debug bezier point display-------------
			/*var targ:Quad = new Quad(5, 5, Color.AQUA);
			targ.x = controlPoint.x;
			targ.y = controlPoint.y;
			addChild(targ);
			
			var targ2:Quad = new Quad(5, 5, Color.AQUA);
			targ2.x = playerProjectile.x;
			targ2.y = playerProjectile.y;
			addChild(targ2);
			
			var targ3:Quad = new Quad(5, 5, Color.AQUA);
			targ3.x = touchLoc.x;
			targ3.y = touchLoc.y;
			addChild(targ3);*/
			
			//Fire the playerProjectile along a bezier curve
			//Set onCompleteParams to signify that this is a player's shot
			TweenMax.to(playerProjectile, fireDuration, {bezier:{values:arcArray, type:"quadratic"}, ease:Linear.easeOut, onComplete:playerProjectile.destroy, onCompleteParams:[true]});		
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