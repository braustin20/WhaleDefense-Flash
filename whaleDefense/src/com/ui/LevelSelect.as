package com.ui
{	
	import com.events.MenuButtonPressed;
	import com.game.Game;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	public class LevelSelect extends Sprite
	{	
		//The background image
		private var backImage:Image;

		//Reference to the main game for asset management
		private var mainGame:Game;
		
		public function LevelSelect(game:Game)
		{
			super();
			
			mainGame = game;
			
			//Load the background image
			backImage = new Image(game.assets.getTexture("wavesBackground"));
			backImage.scaleX = 0.67;
			backImage.scaleY = 0.67;
			addChild(backImage);
			
			//----Place level buttons----
			var Level1Texture:Texture = game.assets.getTexture("LevelButton1");
			var Level1Image:Image = new Image(Level1Texture);
			
			var Level1Button:MenuButton = new MenuButton(450, 200, "Level 1", Level1Image);
			Level1Button.scaleX = .8;
			Level1Button.scaleY = .8;
			addChild(Level1Button);
			
			var Level2Texture:Texture = game.assets.getTexture("LevelButton2");
			var Level2Image:Image = new Image(Level2Texture);
			
			var Level2Button:MenuButton = new MenuButton(650, 200, "Level 2", Level2Image);
			Level2Button.scaleX = .8;
			Level2Button.scaleY = .8;
			addChild(Level2Button);
			
			var Level3Texture:Texture = game.assets.getTexture("LevelButton3");
			var Level3Image:Image = new Image(Level3Texture);
			
			var Level3Button:MenuButton = new MenuButton(850, 200, "Level 3", Level3Image);
			Level3Button.scaleX = .8;
			Level3Button.scaleY = .8;
			addChild(Level3Button);
			
			
			
			//Place back button
			var backTexture:Texture = game.assets.getTexture("Back");
			var backImage:Image = new Image(backTexture);
			
			var backButton:MenuButton = new MenuButton(mainGame.stageWidth/2, 600, "Back", backImage);
			backButton.scaleX = .8;
			backButton.scaleY = .8;
			addChild(backButton);
			
			//Add listener which waits for stage creation
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		//Once the stage is created, add the remaining listeners
		public function onAddedToStage(event:Event):void{		
			//Used for game loop
			this.addEventListener(Event.ENTER_FRAME, this.onUpdate);
			
			//Called if a button is pressed
			this.addEventListener(MenuButtonPressed.PRESSED, onButtonPressed);
			
			//Remove the uneeded stage creation listener
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		protected function onButtonPressed(event:MenuButtonPressed):void{
			switch(event.buttonName){
				case "Level 1" :
					mainGame.switchLevels("Level 1");
					break;
				case "Level 2" :
					mainGame.switchLevels("Level 2");
					break;
				case "Level 3" :
					mainGame.switchLevels("Level 3");
					break;
				case "Back":
					mainGame.switchLevels("Main Menu");
					break;
				default:
					trace("Button has no listener");
			}
		}
		protected function onUpdate():void{
			
		}
	}
}