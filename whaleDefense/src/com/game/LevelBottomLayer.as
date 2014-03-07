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
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onBmpLoad);
			var tempString:String = "com/assets/textures/hittest/" + imgString + ".png";
			trace(tempString);
			var tempRequest:URLRequest = new URLRequest(tempString);
			loader.load(new URLRequest(tempString));
			
			
			//Placeholder sprite
			graphics = sprite;
		
			
			addChild(graphics);
		}
		private function onBmpLoad(event:Event):void{
			layerBmpData = Bitmap(LoaderInfo(event.target).content).bitmapData;
			if(layerBmpData != null){
				trace("Bitmap data found");
			}
			else{
				trace("!!!Bitmap data not found");
			}
		}
	}
}