package com.game
{
	import com.greensock.TimelineMax;
	import com.greensock.easing.Linear;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	

	public class Cannon extends Sprite
	{
		private var graphics:Image;
		
		private var newPlayerProjectile:PlayerProjectile;		
		private var reloadTime:Number = 500;
		private var isReloaded:Boolean = true;
		private var timer:Timer;
		
		private var assetManager:AssetManager;
		
		public var velocity:Number;
				
		public function Cannon(xPos:Number, yPos:Number, game:Game)
		{
			this.x = xPos;
			this.y = yPos;
			
			velocity = 4000;
			assetManager = game.assets;
			
			//Load the catapault sprite
			var cannonTexture:Texture = assetManager.getTexture("shellapultSm");
			var cannonImage:Image = new Image(cannonTexture);
			
			graphics = cannonImage;
		
			//Move the sprite so that it's centered
			graphics.x -= graphics.width/2;
			graphics.y -= graphics.height/2;
			graphics.rotation = .3;
			addChild(graphics);
			this.scaleX = .7;
			this.scaleY = .7;
			
			timer = new Timer(reloadTime, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onReloadComplete);
			
			//Add listener which waits for stage creation
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		//Once the stage is created, add the remaining listeners
		public function onAddedToStage(event:Event):void{		
			
			
			//Remove the uneeded stage creation listener
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onReloadComplete(event:TimerEvent):void{
			isReloaded = true;
			
		}
		public function shootBullet(touchLoc:Point):void{
			if(isReloaded){
				//Load a new image for the projectile on each shot
				var projTexture:Texture = assetManager.getTexture("rockSm");
				var projImage:Image = new Image(projTexture);
				
				//Add a newPlayerProjectile relative to this cannon
				newPlayerProjectile = new PlayerProjectile(0, 0, projImage);
				
				addChild(newPlayerProjectile);
				
				//Create a timeline to hold the animations
				var timeline:TimelineMax = new TimelineMax();
				//Find the midpoint between the current position and target
				var midPoint:Object = findMid(new Point(newPlayerProjectile.x, newPlayerProjectile.y), touchLoc);
				//Add a tween which scales up and moves to the mid point
				timeline.to(newPlayerProjectile, velocityToDuration(new Point(midPoint.x, midPoint.y), newPlayerProjectile), {x:midPoint.x, y:midPoint.y, scaleX:2, scaleY:2, ease:Linear.easeNone});
				//Add a tween directly afterwards which scales down and ends at the target
				timeline.to(newPlayerProjectile, velocityToDuration(touchLoc, newPlayerProjectile), {x:touchLoc.x, y:touchLoc.y, scaleX:0.8, scaleY:0.8, ease:Linear.easeInOut, onComplete:newPlayerProjectile.destroy, onCompleteParams:[true]});
					
				timer.start();
				isReloaded = false;
			}
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