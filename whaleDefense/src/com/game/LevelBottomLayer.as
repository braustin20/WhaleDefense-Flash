package com.game
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.net.URLRequest;
	
	import starling.display.Image;
	import starling.display.Sprite;

	import flash.events.Event;
	
	public class LevelBottomLayer extends Sprite
	{
		public var graphics:Image;
		public var layerBmpData:BitmapData;
		private var loader:Loader;
		
		public function LevelBottomLayer(sprite:Image, imgString:String)
		{ 
			this.x = 0;
			this.y = 0;
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onBmpLoad);
			var tempString:String = "com/assets/textures/hittest/" + imgString + ".png";
			trace(tempString);
			var tempRequest:URLRequest = new URLRequest(tempString);
			trace(tempRequest.url);
			loader.load(new URLRequest(tempString));
			
			
			//Placeholder sprite
			graphics = sprite;
		
			
			addChild(graphics);
			
			//Add listener which waits for stage creation
	//		addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onBmpLoad(event: flash.events.Event):void{
			layerBmpData = Bitmap(LoaderInfo(event.target).content).bitmapData;
			if(layerBmpData != null){
				trace("Bitmap data found");
			}
		}
	/*	private function onAddedToStage():void{
			//Input listeners
			//Add listener for any touch/mouse event
			this.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		public function onTouch(event:TouchEvent):void{
			//Touch data when clicked or tapped down
			var touchDown:Touch = event.getTouch(this.graphics, TouchPhase.ENDED);
			
			//If tapped or clicked, test fire the current cannon at the cursor location
			if (touchDown){
				//Dispatch the event and denote who was the shooter
				dispatchEvent(new ProjectileFired(ProjectileFired.FIRED, touchDown, true, true));
			}
		} */
	}
}