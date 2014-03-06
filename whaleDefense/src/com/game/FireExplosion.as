package com.game
{	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	
	public class FireExplosion extends Sprite
	{
		private var config:XML;
		private var texture:Texture;
		
		private var particleSystem:PDParticleSystem;
		
		public function FireExplosion(xPos:Number, yPos:Number, game:Game)
		{
			super();
			this.x = xPos;
			this.y = yPos;
			
			config = game.assets.getXml("explosionParticle");
			texture = game.assets.getTexture("explosionTexture");
			
			particleSystem = new PDParticleSystem(config, texture);
			addChild(particleSystem);
			Starling.juggler.add(particleSystem);
			particleSystem.start(0.2);
		}
	}
}