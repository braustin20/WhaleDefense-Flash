package com.game{
	import com.levels.Level1;
	import com.ui.MainMenu;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import com.ui.LevelSelect;
	
	public class Game extends Sprite{	
		private var currentLevel:DisplayObject;
		
		//Store stage size
		public var stageWidth:Number = 1280;
		public var stageHeight:Number = 720;
		
		public function Game(){
		//	level = new Level1(stageWidth, stageHeight);
		//	addChild(level);
			var menu:MainMenu = new MainMenu(this);
			currentLevel = menu;
			addChild(menu);
		}
		public function switchLevels(levelName:String):void{
			switch(levelName){
				case "Level 1" :
					var level:Level1 = new Level1(stageWidth, stageHeight);
					addChild(level);
					currentLevel.removeFromParent(true);
					currentLevel = level;
					break;
				case "Level Select" :
					var levelMenu:LevelSelect = new LevelSelect(this);
					addChild(levelMenu);
					currentLevel.removeFromParent(true);
					currentLevel = levelMenu;
					break;
				case "Main Menu" :
					var mainMenu:MainMenu = new MainMenu(this);
					addChild(mainMenu);
					currentLevel.removeFromParent(true);
					currentLevel = mainMenu;
					break;
			}
		}
	}
}