package com.ui
{	
	import com.events.MenuButtonPressed;
	import com.game.Game;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class LevelSelect extends Sprite
	{
		[Embed(source="../assets/buttons.xml",mimeType="application/octet-stream")]
		private var ButtonAtlasData:Class;
		[Embed(source="../assets/buttons.png")]
		private var ButtonAtlasImage:Class;
		
		[Embed(source="../assets/wavesBackground.png")]
		public static const Background:Class;
		
		private var backImage:Image;
		
		//The texture atlases used
		public var buttonTextureAtlas:TextureAtlas;
		
		private var mainGame:Game;
		
		public function LevelSelect(game:Game)
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
			
			var Level1Texture:Texture = buttonTextureAtlas.getTexture("LevelButton1");
			var Level1Image:Image = new Image(Level1Texture);
			
			var Level1Button:MenuButton = new MenuButton(200, 200, "Level 1", Level1Image);
			Level1Button.scaleX = .8;
			Level1Button.scaleY = .8;
			addChild(Level1Button);
			
			
			var backTexture:Texture = buttonTextureAtlas.getTexture("Back");
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
			stage.addEventListener(Event.ENTER_FRAME, this.onUpdate);
			
			//Add player projectile fire listener
			stage.addEventListener(MenuButtonPressed.PRESSED, onButtonPressed);
			
			//Remove the uneeded stage creation listener
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		protected function onButtonPressed(event:MenuButtonPressed):void{
			switch(event.buttonName){
				case "Level 1" :
					mainGame.switchLevels("Level 1");
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