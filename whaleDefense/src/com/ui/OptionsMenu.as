package com.ui
{	
	import com.events.MenuButtonPressed;
	import com.game.Game;
	
	import flash.media.SoundTransform;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;

	public class OptionsMenu extends Sprite
	{	
		//The background image
		private var backImage:Image;

		private var musicSlider:Slider;
		private var effectsSlider:Slider;
		
		//Reference to the main game for asset management
		private var mainGame:Game;
		
		public function OptionsMenu(game:Game)
		{
			super();
			
			mainGame = game;
			
			//Load the background image
			backImage = new Image(game.assets.getTexture("wavesBackground"));
			backImage.scaleX = 0.67;
			backImage.scaleY = 0.67;
			addChild(backImage);
			
			musicSlider = new Slider(mainGame.musicChannel.soundTransform.volume);
			musicSlider.x = 600;
			musicSlider.y = 200;
			addChild(musicSlider);
			
			effectsSlider = new Slider(mainGame.effectsTransform.volume);
			effectsSlider.x = 600;
			effectsSlider.y = 300;
			addChild(effectsSlider);
			
			//Place back button
			var backTexture:Texture = game.assets.getTexture("Back");
			var backImage:Image = new Image(backTexture);
			
			var backButton:MenuButton = new MenuButton(mainGame.stageWidth/2, 600, "Back", backImage);
			backButton.scaleX = .8;
			backButton.scaleY = .8;
			addChild(backButton);
			
			var musicTextField:TextField = new TextField(200, 24, "Music Volume: ", "Arial", 20, Color.BLACK);
			musicTextField.x = musicSlider.x - musicTextField.width;
			musicTextField.y = musicSlider.y - 7;
			addChild(musicTextField);
			
			var effectsTextField:TextField = new TextField(200, 24, "Effects Volume: ", "Arial", 20, Color.BLACK);
			effectsTextField.x = effectsSlider.x - effectsTextField.width;
			effectsTextField.y = effectsSlider.y - 7;
			addChild(effectsTextField);
			
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
				case "Back":
					mainGame.switchLevels("Main Menu");
					break;
				default:
					trace("Button has no listener");
			}
		}
		protected function onUpdate():void{
			if(musicSlider.value != mainGame.musicChannel.soundTransform.volume){
				mainGame.musicChannel.soundTransform = new SoundTransform(musicSlider.value);
				mainGame.musicTransform.volume = musicSlider.value;
			}
			if(effectsSlider.value != mainGame.effectsTransform.volume){
				mainGame.effectsTransform.volume = effectsSlider.value;
			}
		}
	}
}