package com.ui
{	
	import com.game.Game;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class PauseMenu extends Sprite
	{
		//The gray background image
		private var backImage:Image;
		
		//Reference to the game for asset management
		private var mainGame:Game;
		
		public function PauseMenu(game:Game)
		{
			super();
			
			mainGame = game;
			
			//Place the background image
			backImage = new Image(game.assets.getTexture("pauseBackground"));
			backImage.scaleX = 0.67;
			backImage.scaleY = 0.67;
			backImage.alpha = 0.2;
			addChild(backImage);
			
			//Place the Resume button
			var resumeTexture:Texture = game.assets.getTexture("Resume");
			var resumeImage:Image = new Image(resumeTexture);
			
			var resumeButton:MenuButton = new MenuButton(mainGame.stageWidth/2, 200, "Resume", resumeImage);
			resumeButton.scaleX = .8;
			resumeButton.scaleY = .8;
			addChild(resumeButton);
			
			//Place the Exit button
			var exitTexture:Texture = game.assets.getTexture("Exit");
			var exitImage:Image = new Image(exitTexture);
			
			var exitButton:MenuButton = new MenuButton(mainGame.stageWidth/2, 300, "Exit", exitImage);
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
			
			//Remove the uneeded stage creation listener
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		protected function onUpdate():void{
			
		}
	}
}