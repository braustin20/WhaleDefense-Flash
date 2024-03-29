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
	import com.projectiles.GenericProjectile;
	import com.projectiles.PlayerBasicProjectile;
	import com.projectiles.PlayerScatterProjectile;
	import com.projectiles.PlayerPierceProjectile;
	

	public class Catapult extends Sprite
	{
		private var graphics:Image;
		
		private var newPlayerProjectile:PlayerBasicProjectile;	
		private var newPierceProjectile:PlayerPierceProjectile;
		public var reloadTime:Number = 100;
		
		//Used for multi-shot
		public var scatterNum:Number = 6;
		public var scatterDist:Number = 75;
		
		public var isReloaded:Boolean = true;
		private var timer:Timer;
		
		private var assetManager:AssetManager;
		
		public var velocity:Number;
				
		public function Catapult(xPos:Number, yPos:Number, game:Game)
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
		public function shootBasic(touchLoc:Point):void{
			if(isReloaded){
				//Load a new image for the projectile on each shot
				var projTexture:Texture = assetManager.getTexture("rockSm");
				
				//Add a newPlayerProjectile relative to this cannon
				newPlayerProjectile = new PlayerBasicProjectile(0, 0, projTexture);
				
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
		public function shootMulti(touchLoc:Point):void{
			if(isReloaded){
				//Load a new image for the projectile on each shot
				var projTexture:Texture = assetManager.getTexture("rockSm");
				
				var scatter:Object;
				var randDir:Number
				
				//Create an array to store the scattered projectiles
				var projArray:Array = new Array();
				//Create an index to cycle through
				var index:Number = 0;
				//
				for(index = 0; index < scatterNum; index++){
					//Add a newPlayerProjectile relative to this cannon
					projArray[index] = new PlayerScatterProjectile(0, 0, projTexture);
					addChild(projArray[index]);
					
					scatter = generateScatter();
					
					//Create a timeline to hold the animations
					var timeline:TimelineMax = new TimelineMax();
					//Find the midpoint between the current position and target
					var midPoint:Object = findMid(new Point(projArray[index].x, projArray[index].y), touchLoc);
					//Add a tween which scales up and moves to the mid point
					timeline.to(projArray[index], velocityToDuration(new Point(midPoint.x, midPoint.y), projArray[index]), {x:midPoint.x , y:midPoint.y , scaleX:2, scaleY:2, ease:Linear.easeNone});
					//Add a tween directly afterwards which scales down and ends at the target
					timeline.to(projArray[index], velocityToDuration(touchLoc, projArray[index]), {x:touchLoc.x + scatter.x, y:touchLoc.y + scatter.y, scaleX:0.8, scaleY:0.8, ease:Linear.easeInOut, onComplete:projArray[index].destroy, onCompleteParams:[true]});

				}

				timer.start();
				isReloaded = false;
			}
		}
		public function shootPierce(touchLoc:Point):void{
			if(isReloaded){
				//Load a new image for the projectile on each shot
				var projTexture:Texture = assetManager.getTexture("rockSm");
				
				//Add a newPlayerProjectile relative to this cannon
				newPierceProjectile = new PlayerPierceProjectile(0, 0, projTexture);
				
				addChild(newPierceProjectile);
				
				//Create a timeline to hold the animations
				var timeline:TimelineMax = new TimelineMax();
				//Find the midpoint between the current position and target
				var midPoint:Object = findMid(new Point(newPierceProjectile.x, newPierceProjectile.y), touchLoc);
				//Add a tween which scales up and moves to the mid point
				timeline.to(newPierceProjectile, velocityToDuration(new Point(midPoint.x, midPoint.y), newPierceProjectile), {x:midPoint.x , y:midPoint.y , scaleX:2, scaleY:2, ease:Linear.easeNone});
				//Add a tween directly afterwards which scales down and ends at the target
				timeline.to(newPierceProjectile, velocityToDuration(touchLoc, newPierceProjectile), {x:touchLoc.x, y:touchLoc.y, scaleX:0.8, scaleY:0.8, ease:Linear.easeInOut, onComplete:newPierceProjectile.destroy, onCompleteParams:[true]});

				timer.start();
				isReloaded = false;
			}
		}
		//Calculates duration in seconds from a given speed
		public function velocityToDuration(p2:Point, proj:GenericProjectile):Number{
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
		private function generateScatter():Object{
			var randDir:Number;
			var scatterResult:Object = new Object();
			
			randDir = Math.random();
			if(randDir >= 0.5){
				randDir = 1;
			}
			else{
				randDir = -1;
			}
			
			scatterResult.x = (Math.floor(Math.random() * scatterDist) + 10) * randDir;
			randDir = Math.random();
			if(randDir >= 0.5){
				randDir = 1;
			}
			else{
				randDir = -1;
			}
			scatterResult.y = (Math.floor(Math.random() * scatterDist) + 10) * randDir;
			
			return scatterResult;
		}
	}
}