package com.ui
{	
	import com.events.MenuButtonPressed;
	import com.game.Game;
	
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class MainMenu extends Sprite
	{	
		private var backImage:Image;
		private var mainGame:Game;
		
		public function MainMenu(game:Game)
		{
			super();

			mainGame = game;
			
			backImage = new Image(game.assets.getTexture("mainMenuBackground"));
			backImage.scaleX = 0.67;
			backImage.scaleY = 0.67;
			addChild(backImage);
			
			var newGameTexture:Texture = game.assets.getTexture("newGame");
			var newGameImage:Image = new Image(newGameTexture);
			
			var newGameButton:MenuButton = new MenuButton(100, 200, "New Game", newGameImage);
			newGameButton.scaleX = .8;
			newGameButton.scaleY = .8;
			addChild(newGameButton);
			
			var levelSelectTexture:Texture = game.assets.getTexture("levelSelect");
			var levelSelectImage:Image = new Image(levelSelectTexture);
			
			var levelSelectButton:MenuButton = new MenuButton(100, 300, "Level Select", levelSelectImage);
			levelSelectButton.scaleX = .8;
			levelSelectButton.scaleY = .8;
			addChild(levelSelectButton);
			
			var optionsTexture:Texture = game.assets.getTexture("Options");
			var optionsImage:Image = new Image(optionsTexture);
			
			var optionsButton:MenuButton = new MenuButton(100, 400, "Options", optionsImage);
			optionsButton.scaleX = .8;
			optionsButton.scaleY = .8;
			addChild(optionsButton);
			
			//Exit button only used on desktop app and mobile
			
			var exitTexture:Texture = game.assets.getTexture("Exit");
			var exitImage:Image = new Image(exitTexture);
			
			var exitButton:MenuButton = new MenuButton(100, 500, "Exit", exitImage);
			exitButton.scaleX = .8;
			exitButton.scaleY = .8;
			addChild(exitButton);
			
			
			//Add listener which waits for stage creation
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		//Once the stage is created, add the remaining listeners
		public function onAddedToStage(event:Event):void{		
			//Used for game loop
			stage.addEventListener(Event.ENTER_FRAME, this.onUpdate);
			
			//Called if a button is pressed
			stage.addEventListener(MenuButtonPressed.PRESSED, onButtonPressed);
			
			//Remove the uneeded stage creation listener
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		protected function onButtonPressed(event:MenuButtonPressed):void{
			switch(event.buttonName){
				case "New Game" :
					mainGame.switchLevels("Level 1");
					break;
				case "Level Select":
					mainGame.switchLevels("Level Select");
					break;
				case "Options":
					break;
				case "Exit":
					break;
				default:
					trace("Button has no listener");
			}
		}
		protected function onUpdate():void{
			
		}
	}
}