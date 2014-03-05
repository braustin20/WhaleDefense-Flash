package com.game{
	import com.levels.Level1;
	import com.ui.LevelSelect;
	import com.ui.MainMenu;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import flash.media.SoundTransform;
	
	public class Game extends Sprite{	
		private var currentLevel:DisplayObject;
		
		//Store stage size
		public var stageWidth:Number = 1280;
		public var stageHeight:Number = 720;
		
		private var menuMusic:Sound;
		private var level1Music:Sound;
		private var channel:SoundChannel;
		public var soundTransform:SoundTransform;
		
		public var assets:AssetManager;
		
		public function Game(){
			//Initialize an asset manager
			assets = new AssetManager();
			//Ensure console logs are all printed
			assets.verbose = true;
			//Load all assets
			enqueueAssets();
			
		}
		protected function enqueueAssets():void{
			assets.enqueue(EmbeddedAssets);
			//While there are still assets to load, keep loading
			assets.loadQueue(function(ratio:Number):void{
				trace("Loading assets, progress:", ratio);
				
				if (ratio == 1.0){
					startGame();
				}
			});
		}
		protected function startGame():void{
			var menu:MainMenu = new MainMenu(this);
			
			menuMusic = assets.getSound("frozenLoop");
			soundTransform = new SoundTransform(0);
			
			channel = menuMusic.play(0, 9999, soundTransform);
			
			
			level1Music = assets.getSound("happyArcade");
			
			currentLevel = menu;
			addChild(menu);
		}
		public function switchLevels(levelName:String):void{
			switch(levelName){
				case "Level 1" :
					var level:Level1 = new Level1(this);
					removeChild(currentLevel, true);
					addChild(level);					
					currentLevel = level;
					channel.stop();
					channel = level1Music.play(0, 9999, soundTransform);
					break;
				case "Level Select" :
					var levelMenu:LevelSelect = new LevelSelect(this);
					removeChild(currentLevel, true);
					addChild(levelMenu);
					currentLevel = levelMenu;
					break;
				case "Main Menu" :
					var mainMenu:MainMenu = new MainMenu(this);
					removeChild(currentLevel, true);
					addChild(mainMenu);
					currentLevel = mainMenu;
					break;
				case "Main Menu Exit" :
					mainMenu = new MainMenu(this);
					removeChild(currentLevel, true);
					addChild(mainMenu);
					currentLevel = mainMenu;
					channel.stop();
					channel = menuMusic.play(0, 9999, soundTransform);
					break;
			}
		}
	}
}