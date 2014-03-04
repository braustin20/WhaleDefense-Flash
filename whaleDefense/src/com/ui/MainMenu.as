package com.ui
{	
	import com.events.MenuButtonPressed;
	import com.game.Game;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class MainMenu extends Sprite
	{
		[Embed(source="../assets/buttons.xml",mimeType="application/octet-stream")]
		private var ButtonAtlasData:Class;
		[Embed(source="../assets/buttons.png")]
		private var ButtonAtlasImage:Class;
		
		[Embed(source="../assets/mainMenuBackground.png")]
		public static const Background:Class;
		
		private var backImage:Image;
		
		//The texture atlases used
		public var buttonTextureAtlas:TextureAtlas;
		
		private var mainGame:Game;
		
		public function MainMenu(game:Game)
		{
			super();
			
			mainGame = game;
			
			backImage = Image.fromBitmap(new Background());
			backImage.scaleX = 0.67;
			backImage.scaleY = 0.67;
			addChild(backImage);
			
			//The texture atlas
			var buttonsTexture:Texture = Texture.fromBitmap(new ButtonAtlasImage());
			var buttonsXmlData:XML = XML(new ButtonAtlasData());
			buttonTextureAtlas = new TextureAtlas(buttonsTexture, buttonsXmlData);;
			
			var newGameTexture:Texture = buttonTextureAtlas.getTexture("newGame");
			var newGameImage:Image = new Image(newGameTexture);
			
			var newGameButton:MenuButton = new MenuButton(100, 200, "New Game", newGameImage);
			newGameButton.scaleX = .8;
			newGameButton.scaleY = .8;
			addChild(newGameButton);
			
			var levelSelectTexture:Texture = buttonTextureAtlas.getTexture("levelSelect");
			var levelSelectImage:Image = new Image(levelSelectTexture);
			
			var levelSelectButton:MenuButton = new MenuButton(100, 300, "Level Select", levelSelectImage);
			levelSelectButton.scaleX = .8;
			levelSelectButton.scaleY = .8;
			addChild(levelSelectButton);
			
			var optionsTexture:Texture = buttonTextureAtlas.getTexture("Options");
			var optionsImage:Image = new Image(optionsTexture);
			
			var optionsButton:MenuButton = new MenuButton(100, 400, "Options", optionsImage);
			optionsButton.scaleX = .8;
			optionsButton.scaleY = .8;
			addChild(optionsButton);
			
			//Exit button only used on desktop app and mobile
			/*
			var exitTexture:Texture = buttonTextureAtlas.getTexture("Exit");
			var exitImage:Image = new Image(exitTexture);
			
			var exitButton:MenuButton = new MenuButton(100, 500, "Exit", exitImage);
			exitButton.scaleX = .8;
			exitButton.scaleY = .8;
			addChild(exitButton);
			*/
			
			//Add listener which waits for stage creation
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		//Once the stage is created, add the remaining listeners
		public function onAddedToStage(event:Event):void{		
			//Used for game loop
			stage.addEventListener(Event.ENTER_FRAME, this.onUpdate);
			
			//Add player projectile fire listener
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