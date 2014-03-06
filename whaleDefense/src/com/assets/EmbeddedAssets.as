package com.assets
{
	public class EmbeddedAssets
	{
		
		//-----Sprite Sheets-----
		[Embed(source="../assets/textures/buttons.png")]
		public static const buttons:Class;
		
		[Embed(source="../assets/textures/buttons.xml",mimeType="application/octet-stream")]
		public static const buttonsXml:Class;
		
		[Embed(source="../assets/textures/basicWhale.xml",mimeType="application/octet-stream")]
		public static const basicWhaleXml:Class;
		[Embed(source="../assets/textures/basicWhale.png")]
		public static const basicWhale:Class;
		
		[Embed(source="../assets/textures/pauseBackground.png")]
		public static const pauseBackground:Class;
		
		[Embed(source="../assets/textures/level1.xml",mimeType="application/octet-stream")]
		public static const Level1Xml:Class;
		[Embed(source="../assets/textures/level1.png")]
		public static const level1:Class;
		
		[Embed(source="../assets/textures/playerObjects_basic.xml",mimeType="application/octet-stream")]
		public static const BasicObjectsXml:Class;
		[Embed(source="../assets/textures/playerObjects_basic.png")]
		public static const playerObjects_basic:Class;
		
		//-----Load single images-----
		[Embed(source="../assets/textures/mainMenuBackground.png")]
		public static const mainMenuBackground:Class;
		
		[Embed(source="../assets/textures/wavesBackground.png")]
		public static const wavesBackground:Class;
		
		//-----Audio------
		[Embed(source="../assets/audio/happyArcade.mp3")]
		public static const happyArcade:Class;
		
		[Embed(source="../assets/audio/frozenLoop.mp3")]
		public static const frozenLoop:Class;
		
		[Embed(source="../assets/audio/boom9.mp3")]
		public static const boom9:Class;
		
		[Embed(source="../assets/audio/splash.mp3")]
		public static const splash:Class;
		
		[Embed(source="../assets/audio/woosh.mp3")]
		public static const woosh:Class;
		
		//-----Particles-----
		[Embed(source="../assets/particles/explosion.pex", mimeType="application/octet-stream")]
		public static const explosionParticle:Class;
		
		[Embed(source="../assets/particles/explosionTexture.png")]
		public static const explosionTexture:Class;
		
		[Embed(source="../assets/particles/splash.pex", mimeType="application/octet-stream")]
		public static const splashParticle:Class;
		
		[Embed(source="../assets/particles/splashTexture.png")]
		public static const splashTexture:Class;
		
		public function EmbeddedAssets()
		{
			
		}
	}
}