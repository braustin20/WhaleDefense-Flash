package com.game{
	import com.assets.EmbeddedAssets;
	import com.levels.Level1;
	import com.ui.LevelSelect;
	import com.ui.MainMenu;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import starling.utils.Color;
	import com.levels.Level2;
	import com.levels.Level3;
	
	public class Game extends Sprite{	
		private var currentLevel:DisplayObject;
		
		//Loading screen assets
		[Embed(source="../assets/textures/loadingBackground.png")]
		private var loadingBackground:Class;
		private var loadingScreen:Image
		private var loadingBarBack:Quad;
		private var loadingBar:Quad;
		private var loadingBarMaxSize:Number = 900;
		
		//Store stage size
		public var stageWidth:Number = 1280;
		public var stageHeight:Number = 682;
		
		//Music variables
		private var menuMusic:Sound;
		private var level1Music:Sound;
		private var channel:SoundChannel;
		public var soundTransform:SoundTransform;
		
		//Load all gameplay assets
		public var assets:AssetManager;
		
		public function Game(){
			//-------Loading Screen-------
			//The loading screen background
			loadingScreen = Image.fromBitmap(new loadingBackground());
			loadingScreen.scaleX = .67;
			loadingScreen.scaleY = .67;
			addChild(loadingScreen);
			
			//The background to the loading bar
			loadingBarBack = new Quad(900, 20, Color.GRAY);
			loadingBarBack.y = stageHeight - 100;
			loadingBarBack.x = 190;
			addChild(loadingBarBack);
			
			//The green foreground
			loadingBar = new Quad(10, 20, Color.GREEN);
			loadingBarMaxSize = loadingBarBack.width;
			loadingBar.y = stageHeight - 100;
			loadingBar.x = 190;
			addChild(loadingBar);
			
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
				
				//Change the loading bar based on % of assets loaded
				loadingBar.width = (900 * ratio);
				
				if (ratio == 1.0){
					startGame();
				}
			});
		}
		protected function startGame():void{
			
			var menu:MainMenu = new MainMenu(this);
			
			menuMusic = assets.getSound("frozenLoop");
			soundTransform = new SoundTransform(.0);
			
			channel = menuMusic.play(0, 9999, soundTransform);
			
			
			level1Music = assets.getSound("happyArcade");
			
			currentLevel = menu;
			addChild(menu);
			
			removeChild(loadingBar, true);
			removeChild(loadingBarBack, true);
			removeChild(loadingScreen, true);
			
			trace("Current Number of Children: " + this.numChildren);
		}
		public function switchLevels(levelName:String):void{
			switch(levelName){
				case "Level 1" :
					var level:Level1 = new Level1(this);
					addChild(level);	
					removeChild(currentLevel, true);
					currentLevel = level;
					channel.stop();
					channel = level1Music.play(0, 9999, soundTransform);
					break;
				case "Level 2" :
					var level2:Level2 = new Level2(this);
					addChild(level2);	
					removeChild(currentLevel, true);
					currentLevel = level2;
					channel.stop();
					channel = level1Music.play(0, 9999, soundTransform);
					break;
				case "Level 3" :
					var level3:Level3 = new Level3(this);
					addChild(level3);	
					removeChild(currentLevel, true);
					currentLevel = level3;
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