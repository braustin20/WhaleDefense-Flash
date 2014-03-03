package com.game
{
	import com.greensock.TimelineMax;
	import com.greensock.easing.Linear;
	import com.greensock.plugins.BezierThroughPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	

	public class Cannon extends Sprite
	{
		private var graphics:Image;
		private var newPlayerProjectile:PlayerProjectile;
		private var arcArray:Array;
		
		private var textAtlas:TextureAtlas;
		
		public var arcHeight:Number;
		public var velocity:Number;
		
		TweenPlugin.activate([BezierThroughPlugin]);
		
		public function Cannon(xPos:Number, yPos:Number, atlas:TextureAtlas)
		{
			this.x = xPos;
			this.y = yPos;
			
			arcHeight = 200;
			velocity = 1750;
			textAtlas = atlas;
			
			//Load the catapault sprite
			var cannonTexture:Texture = textAtlas.getTexture("shellapultSm");
			var cannonImage:Image = new Image(cannonTexture);
			
			graphics = cannonImage;
		
			//Move the sprite so that it's centered
			graphics.x -= graphics.width/2;
			graphics.y -= graphics.height/2;
			graphics.rotation = .3;
			addChild(graphics);
			
		}
		
		public function shootBullet(touchLoc:Point):void{
			//Load a new image for the projectile on each shot
			var projTexture:Texture = textAtlas.getTexture("rockSm");
			var projImage:Image = new Image(projTexture);
			
			//Add a newPlayerProjectile relative to this cannon
			newPlayerProjectile = new PlayerProjectile(0, 0, projImage);
			
			addChild(newPlayerProjectile);
			
			//Create a timeline to hold the animations
			var timeline:TimelineMax = new TimelineMax();
			//Find the midpoint between the current position and target
			var midPoint:Object = findMid(new Point(newPlayerProjectile.x, newPlayerProjectile.y), touchLoc);
			//Add a tween which scales up and moves to the mid point
			timeline.to(newPlayerProjectile, velocityToDuration(new Point(midPoint.x, midPoint.y), newPlayerProjectile), {x:midPoint.x, y:midPoint.y, scaleX:1.75, scaleY:1.75, ease:Linear.easeNone});
			//Add a tween directly afterwards which scales down and ends at the target
			timeline.to(newPlayerProjectile, velocityToDuration(touchLoc, newPlayerProjectile), {x:touchLoc.x, y:touchLoc.y, scaleX:0.8, scaleY:0.8, ease:Linear.easeInOut, onComplete:newPlayerProjectile.destroy, onCompleteParams:[true]});
		}
		//Calculates duration in seconds from a given speed
		private function velocityToDuration(p2:Point, proj:PlayerProjectile):Number{
			var duration:Number;
			var p1:Point = new Point(proj.x, proj.y);
			
			var distance:Number = Point.distance(p1, p2);
			
			duration = Math.abs(distance/velocity);
			return duration;
		}
		//Returns an object with an x and y property describing the middle of the two points passed in
		private function findMid(p1:Point, p2:Point):Object{
			return {x:p1.x + (p2.x - p1.x)/2, y:p1.y + (p2.y - p1.y)/2};
		}
	}
}