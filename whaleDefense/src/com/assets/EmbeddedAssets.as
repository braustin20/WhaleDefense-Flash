package com.assets
{
	public class EmbeddedAssets
	{
		
		//-----Sprite Sheets-----
		[Embed(source="../assets/textures/buttons.png")]
		public static const buttons:Class;
		
		[Embed(source="/textures/buttons.xml",mimeType="application/octet-stream")]
		public static const buttonsXml:Class;
		
		[Embed(source="../assets/textures/pauseBackground.png")]
		public static const pauseBackground:Class;
		
		[Embed(source="../assets/textures/WhaleTitleAnim.xml",mimeType="application/octet-stream")]
		public static const WhaleTitleAnimXml:Class;
		[Embed(source="../assets/textures/WhaleTitleAnim.png")]
		public static const WhaleTitleAnim:Class;
		
		[Embed(source="../assets/textures/WhaleSpriteAnim.xml",mimeType="application/octet-stream")]
		public static const WhaleSpriteAnimXml:Class;
		[Embed(source="../assets/textures/WhaleSpriteAnim.png")]
		public static const WhaleSpriteAnim:Class;
		
		[Embed(source="../assets/textures/Level1.xml",mimeType="application/octet-stream")]
		public static const Level1Xml:Class;
		[Embed(source="../assets/textures/Level1.png")]
		public static const Level1:Class;
		
		[Embed(source="../assets/textures/Level2.xml",mimeType="application/octet-stream")]
		public static const Level2Xml:Class;
		[Embed(source="../assets/textures/Level2.png")]
		public static const Level2:Class;
		
		[Embed(source="../assets/textures/Level3.xml",mimeType="application/octet-stream")]
		public static const Level3Xml:Class;
		[Embed(source="../assets/textures/Level3.png")]
		public static const Level3:Class;
		
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
		[Embed(source="../assets/audio/levelMusic_1.mp3")]
		public static const levelMusic_1:Class;
		
		[Embed(source="../assets/audio/mainMenu.mp3")]
		public static const mainMenu:Class;
		
		[Embed(source="../assets/audio/explosion.mp3")]
		public static const explosion:Class;
		
		[Embed(source="../assets/audio/splash.mp3")]
		public static const splash:Class;
		
		[Embed(source="../assets/audio/woosh.mp3")]
		public static const woosh:Class;
		
		[Embed(source="../assets/audio/sandHit.mp3")]
		public static const sandHit:Class;
		
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